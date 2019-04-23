require_relative 'base_page'
require_relative '../helper/profile'

##
# Class responsible for all interactions in the Freelancer Search Page
class ProfilesBrowse < BasePage
  include ProfileHelper

  def initialize(browser)
    @browser        = browser
    @profiles_data  = []
  end

  # LOCATORS
  PROFILE_NAME_LOCATOR          = { css: 'h4 a.freelancer-tile-name' }.freeze
  PROFILE_TITLE_LOCATOR         = { css: 'h4.freelancer-tile-title' }.freeze
  PROFILE_COUNTRY_LOCATOR       = { css: 'div.freelancer-tile-location strong.d-md-inline-block' }.freeze
  PROFILE_RATE_LOCATOR          = { css: 'div[data-freelancer-rate] > strong.pull-left' }.freeze
  PROFILE_CARD_SECTION_LOCATOR  = { css: '#oContractorResults > div > div > section.air-card-hover' }.freeze


  # Goes through each search result,
  # gets the desirable data and
  # adds to a class attribute @profiles_data
  #
  # Returns a key-value array with each profile data parsed
  def parse_results
    #TODO: log an error if the return is empty
    profiles_array = find_elements PROFILE_CARD_SECTION_LOCATOR
    profiles_array.each do |profile|
      @profiles_data <<
          {
              name:         get_element_text(PROFILE_NAME_LOCATOR, profile),
              title:        get_element_text(PROFILE_TITLE_LOCATOR, profile),
              country:      get_element_text(PROFILE_COUNTRY_LOCATOR, profile),
              rate:         get_element_text(PROFILE_RATE_LOCATOR, profile)
          }
    end
    @profiles_data
  end

  # Return a random profile name
  def get_random_profile_name
    @profiles_data[rand(0...@profiles_data.count)][:name]
  end

  #TODO: move the locator to a constant
  # Click on the given profile name using it's name as a locator
  def click_on_profile_by_name(name = get_random_profile_name)
    click(css: "h4>a[class='freelancer-tile-name'][title='#{name}']")
    Log.step "Clicked on random profile, profile selected: '#{name}'"
    wait 5
  end

  def verify_keyword_on_profiles(keyword)
    Log.step "Verifying all profiles on Search Page for matching keyword: #{keyword}"
    verify_profiles_with_keyword @profiles_data, keyword
  end

end