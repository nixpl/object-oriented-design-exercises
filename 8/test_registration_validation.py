import unittest
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

class RegistrationValidationTest(unittest.TestCase):
    def setUp(self):
        chrome_options = Options()
        chrome_options.add_argument("--headless")
        chrome_options.add_argument("--no-sandbox")
        chrome_options.add_argument("--disable-dev-shm-usage")
        self.driver = webdriver.Chrome(options=chrome_options)
        self.driver.get('http://localhost:3000/register')

    def tearDown(self):
        self.driver.quit()

    def test_required_fields(self):
        driver = self.driver
        WebDriverWait(driver, 10).until(
            EC.presence_of_element_located((By.ID, "reg-submit"))
        )
        
        username_field = driver.find_element(By.ID, "reg-username")
        email_field = driver.find_element(By.ID, "reg-email")
        password_field = driver.find_element(By.ID, "reg-password")
        submit_btn = driver.find_element(By.ID, "reg-submit")

        submit_btn.click()

        is_user_valid = driver.execute_script("return arguments[0].checkValidity();", username_field)
        self.assertFalse(is_user_valid, "Username field should be required")

    def test_invalid_email_format(self):
        driver = self.driver
        WebDriverWait(driver, 10).until(
            EC.presence_of_element_located((By.ID, "reg-username"))
        )
        
        username_field = driver.find_element(By.ID, "reg-username")
        email_field = driver.find_element(By.ID, "reg-email")
        password_field = driver.find_element(By.ID, "reg-password")
        submit_btn = driver.find_element(By.ID, "reg-submit")

        username_field.send_keys("testuser123")
        email_field.send_keys("invalidemailformat")
        password_field.send_keys("secretpassword1")

        submit_btn.click()

        is_email_valid = driver.execute_script("return arguments[0].checkValidity();", email_field)
        self.assertFalse(is_email_valid, "Email field should signal invalid format natively")

        driver.execute_script("arguments[0].setAttribute('type', 'text')", email_field)
        submit_btn.click()

        error_msg = WebDriverWait(driver, 10).until(
            EC.presence_of_element_located((By.ID, "error-message"))
        )
        self.assertEqual(error_msg.text, "Niepoprawny format adresu e-mail", "Application should display error message")

if __name__ == "__main__":
    unittest.main()
