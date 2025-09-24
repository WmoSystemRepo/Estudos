require 'capybara/cucumber'
require 'selenium-webdriver'
require 'rspec/expectations'

# Configuração para Firefox com ou sem headless
Capybara.register_driver :selenium_firefox do |app|
  options = Selenium::WebDriver::Firefox::Options.new

  # Modo headless (se quiser ativar, descomente abaixo)
  # options.add_argument('--headless')

  options.add_argument('--no-sandbox')
  options.add_argument('--disable-dev-shm-usage')
  options.add_argument('--window-size=1400,900')

  Capybara::Selenium::Driver.new(app, browser: :firefox, options: options)
end

Capybara.default_driver = :selenium_firefox
Capybara.default_max_wait_time = 5
