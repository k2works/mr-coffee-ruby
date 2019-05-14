# frozen_string_literal: true

require_relative '../../app/config/environment'

require 'capybara/cucumber'
require 'selenium-webdriver'
require 'capybara-screenshot/cucumber'

ENV['APP_ENV'] = 'test'

# Capybara自体の設定、ここではどのドライバーを使うかを設定しています
Capybara.configure do |capybara_config|
  capybara_config.default_driver = :selenium_chrome
  capybara_config.default_max_wait_time = 5 # 一つのテストに5秒以上かかったらタイムアウトするように設定しています
end

# Capybaraに設定したドライバーの設定をします
Capybara.register_driver :selenium_chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('headless') unless ENV['BROWSER'] # ヘッドレスモードをonにするオプション
  options.add_argument('--disable-gpu') # 暫定的に必要なフラグとのこと
  options.add_argument('--no-sandbox') # CI
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

# Custom screenshot directory
Capybara.save_path = '../../tmp/capybara'

World do
  Capybara.app = App
end
