require_relative '../log/log'

class BasePage

  attr_accessor :browser

  def initialize(browser)
    @browser = browser
  end

  # clear all the cookies
  def delete_all_cookies
    Log.step 'Cleaning all the browser cookies'
    @browser.manage.delete_all_cookies
  end

  # goes to the url
  def get_page(url)
    @browser.get url
    Log.step "Going to #{url}"
  end

  # finds an element by it's locator and returns it's text
  def get_element_text(locator, wrapper)
    find(locator, wrapper).text
  end

  # click on the given element
  def click(locator)
    find(locator).click
  end

  # find an element by it's locator
  def find(locator, wrapper = nil)
    @browser.find_element locator
    (wrapper ? wrapper : @browser).find_element locator
  end

  # find multiples elements by the same locator
  def find_elements(locator)
    @browser.find_elements locator
  end

  # test-case sleeps for a request period of time(seconds)
  def wait(seconds)
    sleep(seconds)
    warn "Waiting #{seconds}..."
  end

  # find an element and types a text on it
  def find_and_type(locator, text)
    element = find locator
    element.send_keys text
    Log.step "Typing '#{text}' onto element: '#{locator}' "
  end

end