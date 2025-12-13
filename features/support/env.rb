require 'capybara/cucumber'
require 'selenium-webdriver'
require 'rspec'

Capybara.register_driver :chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--start-maximized') 
  options.add_argument('--disable-notifications')
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

Capybara.default_driver = :chrome
Capybara.app_host = 'https://www.automationexercise.com'
Capybara.default_max_wait_time = 10

Before do
  page.driver.browser.manage.window.resize_to(1920, 1080)
end