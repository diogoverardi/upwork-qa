require_relative '../resources/driver/initializer'
require_relative '../resources/pages/base_page'


# initialize the browser driver
browser = Initializer.init_browser(:firefox)

base_page = BasePage.new(browser)

base_page.delete_all_cookies

# goes to the homepage
home_page = base_page.get_page 'http://upwork.com'