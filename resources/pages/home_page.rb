require_relative 'base_page'

##
# Class responsible for all interactions in the Home Page
class HomePage < BasePage

  NAVBAR_SEARCH_INPUT_LOCATOR   = { css: '#layout > nav > div > div.navbar-collapse.d-none.d-lg-flex > div.navbar-form > form > div.input-group.input-group-search-dropdown.input-group-navbar > input.form-control' }.freeze
  NAVBAR_SEARCH_BUTTON_LOCATOR  = { css: '#layout > nav > div > div.navbar-collapse.d-none.d-lg-flex > div.navbar-form > form > div.input-group.input-group-search-dropdown.input-group-navbar > div > button.btn.p-0-left-right' }.freeze

  def search_for_freelancers(keyword)
    focus_onto_search_input
    search_for_keyword keyword
    wait 1
    click NAVBAR_SEARCH_BUTTON_LOCATOR
    # wait 4
  end

  def focus_onto_search_input
    click NAVBAR_SEARCH_INPUT_LOCATOR
    wait 1
  end

  def search_for_keyword(keyword)
    find_and_type NAVBAR_SEARCH_INPUT_LOCATOR, keyword
    Log.step "Typing '#{keyword}' onto navbar search input "
  end

end