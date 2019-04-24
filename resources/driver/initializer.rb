require 'selenium-webdriver'
require_relative '../log/log'

##
# This class will only initialize the browser session
class Initializer

  # Initialize the browser with the Selenium driver
  # the 'self' works like a static method in java
  def self.init_browser(browser)
    Log.step "Initializing #{browser} browser"

    # Init the Selenium
    driver = Selenium::WebDriver.for browser
    driver.manage.timeouts.implicit_wait = 10

    # Returns it
    driver
  end

end
