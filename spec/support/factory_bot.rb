# frozen_string_literal: true

require "factory_bot"

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  config.include RSpec::Matchers::BuiltIn
  config.include Shoulda::Matchers::ActiveRecord

  config.before(:suite) do
    create_seed_data
    FactoryBot.factories.clear
    FactoryBot.find_definitions
  end

  def create_seed_data
    general_settings = [
      ["Start Page", "Which page would you like Feedly to load when you start Feedly?", ["Today", "First Folder", "All"]],
      ["Default Presentation", "Change the presentation setting of all your feeds and boards.", ["Titles-Only View", "Magazine View", "Cards View"]],
      ["Default Sort", "Change the sort setting of all your feeds and boards.", ["Latest", "Oldest"]],
      ["Hide Read Articles Option", "Control if Feedly shows or hides articles after you have had the chance to mark them as read. If you select Show the only you'll see the button to mark read and hide.", ["Show", "Hide"]],
      ["Show Slider", "This won't hide the slider automatically.", ["Show", "Hide"]],
      ["Default Theme", "Please select the default color of the theme", ["Light", "Dark"]]
    ]

    general_settings.each do |setting|
      s = Setting.find_or_create_by(title: setting[0], description: setting[1])
      setting[2].each do |option|
        s.options.find_or_create_by(title: option)
      end
    end
  end
end

