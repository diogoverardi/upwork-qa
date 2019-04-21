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


  # click on the given element
  def click(locator, wait = nil)
    @browser.click locator
  end

end