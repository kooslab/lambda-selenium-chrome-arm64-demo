FROM public.ecr.aws/lambda/python:3.9-arm64

# Install dependencies including wget and unzip first
RUN yum install -y wget unzip \
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
    chromium-headless \
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
    