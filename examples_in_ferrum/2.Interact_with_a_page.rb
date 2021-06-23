require 'puppeteer'

Puppeteer.launch do |browser|
  page = browser.pages.first || browser.new_page
  page.viewport = Puppeteer::Viewport.new(width: 1024, height: 768)

  page.goto("https://google.com")
  input = page.Sx("//input[@name='q']").first
  input.focus
  page.keyboard.type_text("Ruby headless driver for Chrome")

  page.wait_for_navigation do
    page.keyboard.press(:Enter)
  end

  page.wait_for_selector("a > h3")
  puts page.query_selector("a > h3").evaluate("el => el.textContent") # => "rubycdp/ferrum: Ruby Chrome/Chromium driver - GitHub"
end
