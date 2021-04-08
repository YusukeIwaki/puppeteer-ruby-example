require 'puppeteer'

api_token = ENV['BROWSERLESS_IO_API_TOKEN']
ws_url = "wss://chrome.browserless.io?token=#{api_token}"

Puppeteer.connect(browser_ws_endpoint: ws_url) do |browser|
  page = browser.pages.first || browser.new_page
  page.goto("https://www.cman.jp/network/support/go_access.cgi")
  page.screenshot(path: "7.with_browserless.io.png", full_page: true)
end
