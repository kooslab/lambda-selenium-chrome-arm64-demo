import json
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.by import By
from selenium.common.exceptions import NoSuchElementException

def handler(event=None, context=None):
    chrome_options = Options()
    chrome_options.add_argument('--headless')
    chrome_options.add_argument('--no-sandbox')
    chrome_options.add_argument('--disable-dev-shm-usage')
    chrome_options.add_argument('--single-process')
    chrome_options.add_argument('--disable-gpu')
    chrome_options.add_argument('--window-size=1280x1696')
    chrome_options.add_argument('--disable-application-cache')
    chrome_options.add_argument('--disable-infobars')
    chrome_options.add_argument('--hide-scrollbars')
    chrome_options.add_argument('--enable-logging')
    chrome_options.add_argument('--log-level=0')
    chrome_options.add_argument('--ignore-certificate-errors')
    chrome_options.add_argument('--homedir=/tmp')
    chrome_options.binary_location = '/opt/chrome/chrome'
    
    service = Service(executable_path='/opt/chromedriver')
    browser = webdriver.Chrome(service=service, options=chrome_options)

    try:
        browser.get("https://www.example.com/")
        try:
            description = browser.find_element(By.CSS_SELECTOR, "div > h1").text
        except NoSuchElementException:
            description = "Element not found"
            
        return {
            "statusCode": 200,
            "body": json.dumps({
                "message": description,
            }),
        }
    except Exception as e:
        return {
            "statusCode": 500,
            "body": json.dumps({
                "error": str(e),
            }),
        }
    finally:
        browser.quit()

if __name__ == '__main__':
    handler()
