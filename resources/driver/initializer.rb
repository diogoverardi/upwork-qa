require 'selenium-webdriver'
require_relative '../log/log'

class Initializer

  def self.init_browser(browser)
    Log.step "Initializing #{browser} browser"

    driver = Selenium::WebDriver.for browser
    driver.manage.timeouts.implicit_wait = 10

    driver
  end

end
