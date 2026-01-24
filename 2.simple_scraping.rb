require 'puppeteer'

# GitHub's UI has been updated significantly. This sample now uses direct URL navigation
# to the search results page for more reliable operation.
Puppeteer.launch(headless: false, slow_mo: 50, args: ['--guest', '--window-size=1280,800']) do |browser|
  page = browser.pages.first || browser.new_page
  page.viewport = Puppeteer::Viewport.new(width: 1280, height: 800)

  # Navigate directly to search results page
  page.goto("https://github.com/search?q=puppeteer&type=repositories", wait_until: 'networkidle2', timeout: 60000)

  # Wait for search results and extract repository names
  page.wait_for_selector('div[data-testid="results-list"]', timeout: 30000)

  # Get all repository links from search results
  items = page.query_selector_all('div[data-testid="results-list"] h3 a')
  items.first(10).each do |item|
    title = item.evaluate('el => el.innerText')
    puts("==> #{title}")
  end
end
