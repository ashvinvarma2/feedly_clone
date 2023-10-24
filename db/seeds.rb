# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

general_settings = [
  ["Start Page", "Which page would you like Feedly to load when you start Feedly?", ["Today", "First Folder", "All"]],
  ["Default Presentation", "Change the presentation setting of all your feeds and boards.", ["Titles-Only View", "Magazine View", "Cards View", "Article View"]],
  ["Default Sort", "Change the sort setting of all your feeds and boards.", ["Latest", "Oldest"]],
  ["Hide Read Articles", "Control if Feedly shows or hides articles after you have had the chance to mark them as read. You can overwrite it for each feed and board.", ["Hide", "Show"]]
]

general_settings.each do |setting|
  s = Setting.create(title: setting[0], description: setting[1])
  setting[2].each do |option|
    s.options.create(title: option)
  end
end
