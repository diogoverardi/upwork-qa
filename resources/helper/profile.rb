#
# This Module contains public methods that the profile pages can use it
module ProfileHelper

  # Check whether the profiles have a given keyword on it
  def verify_profiles_with_keyword(profiles, keyword)
    # makes the keyword string downcase for comparison
    keyword = keyword.downcase

    # iterates each profile in the search result
    profiles.each do |profile|

      Log.info "||||||||||"
      Log.info "Searching '#{profile[:name]}'"

      # iterate all the data inside each profile
      profile.each do |key, value|

        # calls specific method for checking the skills
        if key == :skills
          check_skills_for_keyword value, keyword
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


  # It receives an array of elements,
  # it extract the text on it and Returns it
  def get_skills(profile_skills)
    skills = []

    profile_skills.each do |skill|

      # skip empty attribute
      unless skill.text.to_s.strip.empty?
        skills << skill.text.downcase
      end

    end

    skills
  end


  private

  # Check all the skills for a given keyword
  def check_skills_for_keyword(skills, keyword)
    # iterate all the skills
    skills.each do |skill|

      # downcase the string for more accurate comparison
      skill = skill.downcase

      # check whether this skill contains the keyword in it
      if skill.include? keyword
        Log.info "Skill #{skill} does include the keyword"
      else
        Log.info "Skill #{skill} does not include the keyword"
      end

    end
  end

end