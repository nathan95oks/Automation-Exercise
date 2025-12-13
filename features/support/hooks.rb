Before('@maximize_window') do
  page.driver.browser.manage.window.maximize
end

Before('@clear_cookies') do
  Capybara.reset_sessions!
  page.driver.browser.manage.delete_all_cookies
end

After('@screenshot_on_finish') do |scenario|
  save_screenshot("screenshots/#{scenario.name}_finished.png")
end

Before('@slow_motion') do
  Capybara.default_max_wait_time = 15
end

After('@database_clean') do
  puts "LOG: Limpiando datos temporales generados por el test..."
end