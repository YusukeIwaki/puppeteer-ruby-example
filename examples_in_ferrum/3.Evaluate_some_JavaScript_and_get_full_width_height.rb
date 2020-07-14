require 'puppeteer'

Puppeteer.launch do |browser|
  page = browser.pages.first || browser.new_page
  page.viewport = Puppeteer::Viewport.new(width: 1024, height: 768)

  page.goto("https://www.google.com/search?q=Ruby+headless+driver+for+Capybara")
  width, height = page.evaluate <<~JS
  [document.documentElement.offsetWidth,
   document.documentElement.offsetHeight]
  JS
  puts [width, height].to_s # => [1024, 1931]
end