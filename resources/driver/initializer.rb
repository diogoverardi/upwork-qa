require 'selenium-webdriver'
require_relative '../log/log'

class Initializer

  def self.init_browser(browser)
    Log.warning browser

    driver = Selenium::WebDriver.for browser
    driver.manage.timeouts.implicit_wait = 10

    return driver
  end

end
