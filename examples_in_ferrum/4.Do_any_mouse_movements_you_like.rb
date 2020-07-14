require 'puppeteer'

Puppeteer.launch(headless: false) do |browser|
  page = browser.pages.first || browser.new_page
  page.viewport = Puppeteer::Viewport.new(width: 1024, height: 768)

  page.goto("https://google.com")
  page.mouse.instance_eval do
    move(0, 0)
    down
    move(0, 100)
    move(100, 100)
    move(100, 0)
    move(0, 0)
    up
  end
end