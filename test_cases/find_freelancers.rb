require_relative '../resources/driver/initializer'
require_relative '../resources/pages/home_page'
require_relative '../resources/pages/profiles_browse'
require_relative '../resources/pages/profile_user'
require_relative '../resources/config/find_freelancers'

##############################################################################
# Test case
#
# Run <browser>(dynamic)
#
# Clear <browser> cookies
#
# Go to www.upwork.com
#
# Focus onto "Find freelancers"
#
# Enter <keyword>(dynamic) into the search input right from the dropdown and submit it (click on the magnifying glass button)
#
# Parse the 1st page with search results: store info given on the 1st page of search results as structured data of any chosen by you type (i.e. hash of hashes or array of hashes, whatever structure handy to be parsed).
#
# Make sure at least one attribute (title, overview, skills, etc) of each item (found freelancer) from parsed search results contains <keyword> Log in stdout
# which freelancers and attributes contain <keyword> and which do not.
#
# Click on random freelancer's title
#
# Get into that freelancer's profile
#
# Check that each attribute value is equal to one of those stored in the structure created in #67
#
# Check whether at least one attribute contains <keyword>
##############################################################################


# Set the browser and keyword to be used on this session
def get_browser(browser)
  if browser == 'chrome'
    :chrome
  end
  :firefox
end

browser_arg = (ARGV[0] ? get_browser(ARGV[0]) :DEFAULT_BROWSER)
keyword     = (ARGV[1] ? ARGV[1] : DEFAULT_KEYWORD)

# initialize the browser driver
browser = Initializer.init_browser(browser_arg)

# creates an instance of the home_page
page = HomePage.new browser

# delete all browser cookies
page.delete_all_cookies

# goes to url
page.get_page 'http://www.upwork.com'

# search for profiles with specific keyword
page.search_for_freelancers keyword




profiles_search_page = ProfilesBrowse.new browser

# parse profiles results
search_results = profiles_search_page.parse_results

# check which profiles have the keyword on it
profiles_search_page.verify_keyword_on_profiles keyword

# click on a random profile and get into it
profiles_search_page.click_on_profile_by_name




profile_user_page = ProfileUser.new browser

# Check that each attribute value is equal to one of those stored in the structure created in #67
profile_user_page.verify_attributes_from_search search_results

# Check whether at least one attribute contains <keyword>
profile_user_page.verify_keyword_on_profile keyword

# ends the test-case
profile_user_page.quit


# Print the Log counts
Log.print_counts
