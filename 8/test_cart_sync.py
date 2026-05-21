import unittest
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

class CartSyncTest(unittest.TestCase):
    def setUp(self):
        chrome_options = Options()
        chrome_options.add_argument("--headless")
        chrome_options.add_argument("--no-sandbox")
        chrome_options.add_argument("--disable-dev-shm-usage")
        self.driver = webdriver.Chrome(options=chrome_options)
        self.driver.get('http://localhost:3000/')
        self.driver.execute_script("window.localStorage.clear();")
        self.driver.refresh()

    def tearDown(self):
        self.driver.quit()

    def test_cart_synchronization_across_tabs(self):
        driver = self.driver
        WebDriverWait(driver, 10).until(
            EC.presence_of_element_located((By.XPATH, "//button[contains(text(), 'Dodaj do koszyka')]"))
        )
        
        main_window = driver.current_window_handle
        
        driver.execute_script("window.open('http://localhost:3000/cart', '_blank');")
        WebDriverWait(driver, 10).until(EC.number_of_windows_to_be(2))
        
        cart_window = [window for window in driver.window_handles if window != main_window][0]
        
        driver.switch_to.window(cart_window)
        WebDriverWait(driver, 10).until(
            EC.presence_of_element_located((By.XPATH, "//*[contains(text(), 'Twój koszyk jest pusty.')]"))
        )
        
        empty_msg_elements = driver.find_elements(By.XPATH, "//*[contains(text(), 'Twój koszyk jest pusty.')]")
        self.assertGreater(len(empty_msg_elements), 0)
        
        driver.switch_to.window(main_window)
        
        add_buttons = driver.find_elements(By.XPATH, "//button[contains(text(), 'Dodaj do koszyka')]")
        self.assertGreater(len(add_buttons), 0)
        
        add_buttons[0].click()
        
        driver.switch_to.window(cart_window)
        
        WebDriverWait(driver, 10).until(
            EC.presence_of_element_located((By.XPATH, "//button[contains(text(), 'Usuń')]"))
        )
        
        remove_buttons = driver.find_elements(By.XPATH, "//button[contains(text(), 'Usuń')]")
        self.assertEqual(len(remove_buttons), 1)

if __name__ == "__main__":
    unittest.main()