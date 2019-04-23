#
# This Module contains public methods that the profile pages can use it
module ProfileHelper

  # Check whether the profiles has a given keyword on it
  def verify_profiles_with_keyword(profiles, keyword)
    # makes the keyword string downcase for comparison
    keyword = keyword.downcase

    # iterates each profile in the search result
    profiles.each do |profile|

      Log.info "||||||||||"
      Log.info "Searching '#{profile[:name]}'"

      # iterate all the data inside each profile
      profile.each do |key, value|

        # don't verify the keyword on the profile's name
        if key == :name
          next
        end

        # downcase the string for more accurate comparison
        value = value.downcase

        # check whether the current profile data contains the keyword in it
        if value.include? keyword
          Log.info "#{key} does include the keyword"
        else
          Log.info "#{key} does not include the keyword"
        end

      end

    end

  end

end