require_relative 'base_page'

class ProfileUser < BasePage

  def initialize(browser)
    @browser = browser
  end

  # LOCATORS
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
    profile_page        = get_profile_page_data
    profile_from_search = get_profile_from_search search_results, profile_page[:name]

    profile_page.each do |key, value|
      print key
      print value
      print '--dv--'
    end

  end

  #TODO: remove the @browser parameter
  #TODO: is_a_company_page is called 4 times, make it just one
  def get_profile_page_data
    {
        name:         get_element_text((is_a_company_page ? COMPANY_NAME_LOCATOR    : PROFILE_NAME_LOCATOR), @browser),
        title:        get_element_text((is_a_company_page ? COMPANY_TITLE_LOCATOR   : PROFILE_TITLE_LOCATOR), @browser),
        country:      get_element_text((is_a_company_page ? COMPANY_COUNTRY_LOCATOR : PROFILE_COUNTRY_LOCATOR), @browser),
        rate:         get_element_text((is_a_company_page ? COMPANY_RATE_LOCATOR    : PROFILE_RATE_LOCATOR), @browser)
    }
  end

  #TODO: remove the log
  def is_a_company_page
    Log.info get_current_url
    if get_current_url.include? 'companies'
      true
    else
      false
    end
  end


  def get_profile_from_search(search_results, name)
    search_results.each do |profile|

      if profile[:name] == name
        return profile
      end

    end
  end

end