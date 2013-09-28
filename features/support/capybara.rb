# Screenshot failing features
require 'capybara-screenshot/cucumber'

After do |scenario|
  if scenario.failed?
    #screenshot_and_open_image
    save_and_open_page
  end
end
