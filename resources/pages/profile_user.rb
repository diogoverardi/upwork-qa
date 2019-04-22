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

  end

end