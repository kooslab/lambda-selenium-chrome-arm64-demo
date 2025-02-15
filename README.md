# lambda-selenium-chrome-arm64-demo

A minimal demo repository showing how to run **Selenium** and **Chrome** in an **ARM64** AWS Lambda container. Built on Amazon Linux 2 (ARM64) base image.

## Overview

- **Language**: Python 3.9
- **Browser**: Headless Chromium
- **Driver**: ChromeDriver
- **Container**: AWS Lambda base image (ARM64)
- **Purpose**: Quickly prove Selenium + Chrome can run on AWS Lambda for an ARM64 architecture (e.g., M1/M2 Macs).

## Project Structure

## Download and install ChromeDriver

Check your chrome version and find the corresponding ChromeDriver version at https://googlechromelabs.github.io/chrome-for-testing/

unzip the downloaded file and copy the chromedriver binary to /usr/local/bin/chromedriver
For my case, I downloaded the chromedriver-mac-arm64.zip file and extracted it to the current directory.

```bash
unzip chromedriver-mac-arm64.zip
sudo mv chromedriver-mac-arm64/chromedriver /usr/local/bin/chromedriver
```

# Remove quarantine attribute

```bash
xattr -d com.apple.quarantine /usr/local/bin/chromedriver
```

# Make chromedriver executable

```bash
chmod +x /usr/local/bin/chromedriver
```

# Verify ChromeDriver installation

```bash
chromedriver --version
```
