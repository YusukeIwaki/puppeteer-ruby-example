require 'puppeteer'

Puppeteer.launch(headless: false) do |browser|
  page = browser.pages.first || browser.new_page
  page.goto("https://github.com/YusukeIwaki")
  page.screenshot(path: "1.capture_a_site.png")
end
