require_relative 'base_page'
require_relative '../helper/profile'

##
# Class responsible for all interactions in the Profile Page
# for both Freelancer or Company type of user
class ProfileUser < BasePage

  # This will include the Module into this class
  # (not a inheritance)
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
  PROFILE_SKILLS_LOCATOR        = { css: 'div.o-profile-skills a' }.freeze
  PROFILE_DESCRIPTION_LOCATOR   = { css: 'o-profile-overview:nth-child(1) p[itemprop="description"] span[ng-show="!open"]:nth-child(1)' }.freeze

  GENERAL_PROFILE_BUTTON_LOCATOR = { css: 'button[data-ng-click="$ctrl.selectGeneralProfile()"]' }.freeze

  COMPANY_NAME_LOCATOR          = { css: '#main > div.ng-scope > div > div > div.row > div.col-md-9 > div > div.air-card.m-0-top-bottom > div.media > div.media-body > h2' }.freeze
  COMPANY_TITLE_LOCATOR         = { css: '#main > div.ng-scope > div > div > div.row > div.col-md-9 > div > div.air-card.m-0-top-bottom > h3' }.freeze
  COMPANY_DESCRIPTION_LOCATOR   = { css: 'div[data-ng-if="vm.profile.description"] span.ng-scope' }.freeze
  COMPANY_COUNTRY_LOCATOR       = { css: '#main > div.ng-scope > div > div > div.row > div.col-md-9 > div > div.air-card.m-0-top-bottom > div.media > div.media-body > div.m-sm-bottom > strong' }.freeze
  COMPANY_RATE_LOCATOR          = { css: '#main > div.ng-scope > div > div > div.row > div.col-md-9 > div > div.air-card.m-0-top-bottom > div.row > div:nth-child(1) > h4 > span' }.freeze


  # Compares the profile attributes between profile page and search page
  # and log the results
  def verify_attributes_from_search(search_results)
    # click in the general profile button
    # if there's one
    goes_to_general_profile

    profile_page        = get_profile_page_attributes
    profile_from_search = get_profile_from_search search_results, profile_page[:name]

    Log.step "Comparing data between Profile Page and Search Page for '#{profile_page[:name]}' "

    # Adds just one profile to a list so it can
    # compare it later with a given keyword
    @profile << profile_page

    # Verify if the attribute is the same from the search page
    profile_page.each do |key, value|

      # Calls a specific method for comparing the skills attribute
      if key == :skills
        compare_profile_skills profile_from_search[key], value
        next
      end

      # Makes a specific comparison for the description
      if key == :description
        compare_profile_description profile_from_search[key], value
        next
      end

      # Compare the attributes
      if value == profile_from_search[key]
        message = "The attribute '#{key}' matches the one shown in the search"
      else
        message = "The attribute '#{key}' is different from the search | profile: #{value} | search: #{profile_from_search[key]}"
      end

      Log.info message
    end

  end

  # Check if the profile description contains the profile search description
  def compare_profile_description(search_description, profile_description)
    message = "The attribute 'Description' don't match"

    # remove the last three dots in the end of the search description
    # for comparison
    search_description  = search_description.gsub('...', '')

    # TODO: maybe add this to longer pieces of text
    # profile_description = profile_description.gsub("\n", " ")

    # puts "profile_description [ #{profile_description}"
    # puts "search_description  [ #{search_description}"

    if profile_description.include? search_description
      message = "The attribute 'Description' on the profile contains the piece that is displayed at the search page"
    end

    Log.info message
  end

  # Compare skills between the profile and search page
  # and log the skills that weren't on both pages
  def compare_profile_skills(search_skills, profile_page_skills)
    non_matching_skills = profile_page_skills - search_skills

    if non_matching_skills
      Log.info "These skills where not in the search #{non_matching_skills}"
    end
  end

  # Clicks on the general profile button
  # if it's being displayed
  def goes_to_general_profile
    if is_displayed GENERAL_PROFILE_BUTTON_LOCATOR
      click GENERAL_PROFILE_BUTTON_LOCATOR
      wait 1
    end
  end

  # Assemble a key-value array containing the profile attributes
  # and Returns it
  def get_profile_page_attributes
    is_company = is_a_company_page
    {
      name:         get_element_text((is_company ? COMPANY_NAME_LOCATOR    : PROFILE_NAME_LOCATOR)),
      title:        get_element_text((is_company ? COMPANY_TITLE_LOCATOR   : PROFILE_TITLE_LOCATOR)),
      description:  get_element_text((is_company ? COMPANY_DESCRIPTION_LOCATOR : PROFILE_DESCRIPTION_LOCATOR)),
      country:      get_element_text((is_company ? COMPANY_COUNTRY_LOCATOR : PROFILE_COUNTRY_LOCATOR)),
      rate:         get_element_text((is_company ? COMPANY_RATE_LOCATOR    : PROFILE_RATE_LOCATOR)),
      skills:       get_profile_skills
    }
  end

  # Checks for keyword on profile attributes
  def verify_keyword_on_profile(keyword)
    Log.step "Verifying all attributes on Profile Page for matching keyword: #{keyword}"
    verify_profiles_with_keyword @profile, keyword
  end

  # Return a array with the profile skills
  def get_profile_skills
    profile_skills = find_elements PROFILE_SKILLS_LOCATOR
    get_skills profile_skills
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