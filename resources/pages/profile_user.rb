require_relative 'base_page'
require_relative '../helper/profile'

##
# Class responsible for all interactions in the Profile Page
# for both Freelancer or Company type of user
class ProfileUser < BasePage
  include ProfileHelper

  def initialize(browser)
    @browser = browser
    @profile = []
  end

  # Locators
  # the locators change if a profile belongs to a company
  PROFILE_NAME_LOCATOR          = { css: '#optimizely-header-container-default > div.row.m-lg-bottom > div.col-xs-12.col-sm-8.col-md-9.col-lg-10 > div > div.media-body > h2 > span' }.freeze
  PROFILE_TITLE_LOCATOR         = { css: '#optimizely-header-container-default > div.overlay-container > div:nth-child(1) > h3 > span > span.ng-binding' }.freeze
  PROFILE_COUNTRY_LOCATOR       = { css: '#optimizely-header-container-default > div.row.m-lg-bottom > div.col-xs-12.col-sm-8.col-md-9.col-lg-10 > div > div.media-body > div.fe-profile-header-local-time > fe-profile-map > span > ng-transclude > fe-profile-location-label > span.w-700 > span:nth-child(2)' }.freeze
  PROFILE_RATE_LOCATOR          = { css: '#optimizely-header-container-default > div.m-lg-top.cfe-aggregates > ul > li:nth-child(1) > div.up-active-container.ng-scope > div > h3 > cfe-profile-rate > span > span' }.freeze

  COMPANY_NAME_LOCATOR          = { css: '#main > div.ng-scope > div > div > div.row > div.col-md-9 > div > div.air-card.m-0-top-bottom > div.media > div.media-body > h2' }.freeze
  COMPANY_TITLE_LOCATOR         = { css: '#main > div.ng-scope > div > div > div.row > div.col-md-9 > div > div.air-card.m-0-top-bottom > h3' }.freeze
  COMPANY_COUNTRY_LOCATOR       = { css: '#main > div.ng-scope > div > div > div.row > div.col-md-9 > div > div.air-card.m-0-top-bottom > div.media > div.media-body > div.m-sm-bottom > strong' }.freeze
  COMPANY_RATE_LOCATOR          = { css: '#main > div.ng-scope > div > div > div.row > div.col-md-9 > div > div.air-card.m-0-top-bottom > div.row > div:nth-child(1) > h4 > span' }.freeze


  def verify_data_from_search(search_results)
    profile_page        = get_profile_page_attributes
    profile_from_search = get_profile_from_search search_results, profile_page[:name]

    Log.step "Comparing data between Profile Page and Search Page for '#{profile_page[:name]}' "

    # Adds just one profile to a list so it can
    # compare it later with a given keyword
    @profile << profile_page

    # Verify if the attribute is the same from the search page
    profile_page.each do |key, value|

      if value == profile_from_search[key]
        message = "The data '#{key}' matches the one shown in the search"
      else
        message = "The data '#{key}' is different from the search | profile: #{value} | search: #{profile_from_search[key]}"
      end

      Log.info message
    end

  end

  # Assemble a key-value array containing the profile attributes
  # and Returns it
  def get_profile_page_attributes
    is_company = is_a_company_page
    {
        name:         get_element_text((is_company ? COMPANY_NAME_LOCATOR    : PROFILE_NAME_LOCATOR)),
        title:        get_element_text((is_company ? COMPANY_TITLE_LOCATOR   : PROFILE_TITLE_LOCATOR)),
        country:      get_element_text((is_company ? COMPANY_COUNTRY_LOCATOR : PROFILE_COUNTRY_LOCATOR)),
        rate:         get_element_text((is_company ? COMPANY_RATE_LOCATOR    : PROFILE_RATE_LOCATOR))
    }
  end

  def verify_keyword_on_profile(keyword)
    Log.step "Verifying all attributes on Profile Page for matching keyword: #{keyword}"
    verify_profiles_with_keyword @profile, keyword
  end

  # Returns true(bool) if the current profile page
  # is a company page, false(bool) otherwise
  def is_a_company_page
    if get_current_url.include? 'companies'
      true
    else
      false
    end
  end

  # Finds a profile in the search result by it's name
  # Returns the profile if found, false(bool) otherwise
  def get_profile_from_search(search_results, name)
    search_results.each do |profile|

      if profile[:name] == name
        return profile
      end

    end

    false
  end

end