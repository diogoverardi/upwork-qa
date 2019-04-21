require_relative '../locators/home_page'


class HomePage < BasePage

  search_navbar_button = { :css => 'div.navbar-form > form > div.input-group.input-group-search-dropdown.input-group-navbar' }

  def focus_onto_searchbar
    BasePage.click focus_onto_searchbar

  end

end