require 'puppeteer'

Puppeteer.launch(headless: false, slow_mo: 50, args: ['--guest', '--window-size=1280,800']) do |browser|
  page = browser.pages.first || browser.new_page
  page.viewport = Puppeteer::Viewport.new(width: 1280, height: 800)
  page.goto("https://github.com/", wait_until: 'domcontentloaded')

  form = page.S("form.js-site-search-form")
  searchInput = form.S("input.header-search-input")
  searchInput.type_text("puppeteer")
  await_all(
    page.async_wait_for_navigation,
    searchInput.async_press("Enter"),
  )

  list = page.S("ul.repo-list")
  items = list.SS("div.f4")
  items.each do |item|
    title = item.Seval("a", "a => a.innerText")
    puts("==> #{title}")
  end
end
