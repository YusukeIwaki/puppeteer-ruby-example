require 'puppeteer'

Puppeteer.launch do |browser|
  page = browser.pages.first || browser.new_page
  page.viewport = Puppeteer::Viewport.new(width: 1024, height: 768)

  page.goto("https://google.com")
  page.screenshot(path: "google.png")
end