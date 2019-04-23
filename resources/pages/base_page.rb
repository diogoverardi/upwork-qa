require_relative '../log/log'

##
# Class that all pages should inherit from
# it contains basic methods that all the other pages will use it
class BasePage

  # Makes this variable accept writing/reading
  attr_accessor :browser

  def initialize(browser)
    @browser = browser
  end

  # Clear all the cookies
  def delete_all_cookies
    @browser.manage.delete_all_cookies
    Log.step 'Cleaning all browser cookies'
  end

  # Goes to the given url
  def get_page(url)
    @browser.get url
    Log.step "Going to '#{url}' url"
  end

  # Finds an element by it's given locator
  # and returns it's text
  def get_element_text(locator, wrapper = nil)
    find(locator, wrapper).text
  end

  # Click on the element by it's locator
  def click(locator)
    find(locator).click
  end

  # Find an element by it's locator
  def find(locator, wrapper = nil)
    # @browser.find_element locator
    (wrapper ? wrapper : @browser).find_element locator
  end

  # Find multiples elements by it's given locator
  # and returns it
  def find_elements(locator)
    @browser.find_elements locator
  end

  # Stop the script execution by a given time(seconds)
  def wait(seconds)
    sleep(seconds)
    warn "Waiting #{seconds} seconds..."
  end

  # Find an element by it's locator
  # and type a text on it
  def find_and_type(locator, text)
    element = find locator
    element.send_keys text
  end

  # Returns the current browser url
  def get_current_url
    @browser.current_url
  end

  # Close the browser
  def quit
    @browser.quit
    Log.step 'Closing the browser...'
  end

end