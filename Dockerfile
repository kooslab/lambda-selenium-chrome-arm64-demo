# For ARM64 base image:
    FROM public.ecr.aws/lambda/python:3.9-arm64

    # Install dependencies: chromium, fonts, and any libs for Chrome
    # Using apt-get because the AWS Lambda base images are mostly based on Amazon Linux 2
    # For convenience, you can install from Amazon Linux repos or just a direct rpm. 
    # The example below uses google's official stable repo if you prefer that approach.
    RUN yum install -y \
        alsa-lib \
        atk \
        cups-libs \
        gtk3 \
        libXcomposite \
        libXcursor \
        libXi \
        libXrandr \
        libXScrnSaver \
        pango \
        xorg-x11-fonts-Type1 \
        xorg-x11-fonts-misc \
        # For unzip:
        unzip \
        # For chromium:
        chromium-headless \
        # or if you prefer full chromium:
        # chromium
        # or google-chrome-stable if you have that repo set up
        && yum clean all
    
    # Install Chrome for Testing (stable version 133.0.6943.98)
    RUN wget https://storage.googleapis.com/chrome-for-testing-public/133.0.6943.98/linux64/chrome-linux64.zip -O /tmp/chrome.zip \
        && unzip /tmp/chrome.zip -d /opt \
        && mv /opt/chrome-linux64 /opt/chrome \
        && ln -s /opt/chrome/chrome /usr/bin/chrome \
        && rm -f /tmp/chrome.zip

    # Install matching ChromeDriver 133.0.6943.98
    RUN wget https://storage.googleapis.com/chrome-for-testing-public/133.0.6943.98/linux64/chromedriver-linux64.zip -O /tmp/chromedriver.zip \
        && unzip /tmp/chromedriver.zip -d /tmp \
        && mv /tmp/chromedriver-linux64/chromedriver /usr/local/bin/chromedriver \
        && chmod +x /usr/local/bin/chromedriver \
        && rm -rf /tmp/chromedriver.zip /tmp/chromedriver-linux64
    
    # Copy your Python code
    COPY app.py ${LAMBDA_TASK_ROOT}
    COPY requirements.txt ./
    
    # Install Python dependencies
    RUN python3.9 -m pip install -r requirements.txt --target "${LAMBDA_TASK_ROOT}"
    
    # Set the command to your Lambda handler
    CMD [ "app.lambda_handler" ]
    