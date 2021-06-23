require 'puppeteer'

Puppeteer.launch(headless: false, slow_mo: 50, args: ['--guest', '--window-size=1280,800']) do |browser|
  page = browser.pages.first || browser.new_page
  page.viewport = Puppeteer::Viewport.new(width: 1280, height: 800)
  page.goto("https://github.com/", wait_until: 'domcontentloaded')

  form = page.query_selector("form.js-site-search-form")
  search_input = form.query_selector("input.header-search-input")
  search_input.type_text("puppeteer")

  page.wait_for_navigation do
    search_input.press('Enter')
  end

  list = page.query_selector("ul.repo-list")
  items = list.query_selector_all("div.f4")
  items.each do |item|
    title = item.eval_on_selector("a", "a => a.innerText")
    puts("==> #{title}")
  end
end
