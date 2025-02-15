import json
import os
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.by import By
from dotenv import load_dotenv
load_dotenv()

def lambda_handler(event=None, context=None):
    # Path to the ChromeDriver binary (as installed in the Dockerfile)

    load_dotenv()
    # Update the chrome binary and driver paths
    # this is for linux arm64
    chrome_binary_path = "/opt/chrome/chrome"
    chromedriver_path = "/opt/chromedriver"

    # for mac osx m1
    # chromedriver_path = os.getenv("CHROMEDRIVER_PATH", "/usr/local/bin/chromedriver")

    # Create Chrome options
    chrome_options = Options()
    chrome_options.binary_location = chrome_binary_path  # Specify the Chrome binary location
    chrome_options.add_argument("--headless")
    chrome_options.add_argument("--no-sandbox")
    chrome_options.add_argument("--disable-gpu")
    chrome_options.add_argument("--disable-dev-shm-usage")
    chrome_options.add_argument("--ignore-certificate-errors")
    chrome_options.add_argument("--ignore-ssl-errors")
    # If Chromium is not on the default PATH, specify the binary location:
    # chrome_options.binary_location = "/usr/bin/chromium-browser"
    # (Adjust this if you install Chrome/Chromium somewhere else)

    # Create a Service object pointing to our ChromeDriver
    service = Service(chromedriver_path)

    # Create the WebDriver
    driver = webdriver.Chrome(service=service, options=chrome_options)

    try:
        # Navigate to example.com
        driver.get("https://example.com/")

        # example.com typically has a structure like: <div><h1>Example Domain</h1></div>
        h1_element = driver.find_element(By.CSS_SELECTOR, "div > h1")
        text = h1_element.text
        print('h1 text', text)

        return {
            "statusCode": 200,
            "body": json.dumps({"h1": text})
        }
    finally:
        driver.quit()
