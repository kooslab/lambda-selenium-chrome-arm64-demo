# lambda-selenium-chrome-x86_64-demo

A minimal demo repository showing how to run **Selenium** and **Chrome** in an **x86_64** AWS Lambda container. Built on Amazon Linux 2 (x86_64) base image.

Most of the code and file structure in this repository are based on [lambda-selenium-docker](https://github.com/uiandwe/lambda-selenium-docker).

## Overview

- **Language**: Python 3.9
- **Browser**: Headless Chromium
- **Driver**: ChromeDriver
- **Container**: AWS Lambda base image (x86_64)
- **Purpose**: Quickly prove Selenium + Chrome can run on AWS Lambda for x86_64 architecture.

## Project Structure

## Download and install ChromeDriver

Check your chrome version and find the corresponding ChromeDriver version at https://googlechromelabs.github.io/chrome-for-testing/

unzip the downloaded file and copy the chromedriver binary to /usr/local/bin/chromedriver
For my case, I downloaded the chromedriver-linux64.zip file and extracted it to the current directory.
