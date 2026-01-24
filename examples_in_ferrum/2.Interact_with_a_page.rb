require 'puppeteer'

# NOTE: Google UI has been updated. Search box is now a textarea and
# search result selectors have changed.
Puppeteer.launch(headless: false) do |browser|
  page = browser.pages.first || browser.new_page
  page.viewport = Puppeteer::Viewport.new(width: 1024, height: 768)

  page.goto("https://google.com", wait_until: 'networkidle2', timeout: 60000)
  # Google changed search box from input to textarea
  page.wait_for_selector('textarea[name="q"]', timeout: 30000)
  input = page.query_selector('textarea[name="q"]')
  input.focus
  page.keyboard.type_text("Ruby headless driver for Chrome")

  page.wait_for_navigation do
    page.keyboard.press(:Enter)
  end

  # Wait for search results - h3 is inside the link
  page.wait_for_selector("h3", timeout: 30000)
  puts page.query_selector("h3").evaluate("el => el.textContent")
end
