require_relative 'base_page'

class ProfilesBrowse < BasePage

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

  def get_random_profile_name
    Log.step 'Getting a random profile'
    @profiles_data[rand(0...@profiles_data.count)][:name]
  end

  def click_on_profile_by_name(name = get_random_profile_name)
    click(css: "h4>a[class='freelancer-tile-name'][title='#{name}']")
    Log.step "Clicked on random profile, #{name} was the chosen one."
    wait 5
  end

  def verify_profiles_with_keyword(keyword)
    Log.step "Verifying which profiles contain the keyword: #{keyword}"

    keyword = keyword.downcase

    @profiles_data.each do |profile|

      Log.info "||||||||||"
      Log.info "Searching '#{profile[:name]}'"

      profile.each do |key, value|

        # don't verify the keyword on the profile's name
        if key == :name
          next
        end

        # downcase the string for more accurate comparison
        value = value.downcase

        if value.include? keyword
          Log.info "#{key} does include the keyword"
        else
          Log.info "#{key} does not include the keyword"
        end

      end
    end

  end

end