require 'puppeteer'

Puppeteer.launch(headless: false, slow_mo: 50, args: ['--guest', '--window-size=1280,800']) do |browser|
  page = browser.pages.first || browser.new_page
  page.emulate(Puppeteer::Devices.iPhone_X)

  page.goto('https://hotel.testplanisphere.dev/ja/')

  page.click("button.navbar-toggler")
  sleep 1 # wait for menu opened.
  reservation_link = page.SS('#navbarNav li').find do |item|
    item.evaluate('(el) => el.textContent').strip == '宿泊予約'
  end
  await_all(
    page.async_wait_for_navigation,
    reservation_link.async_click,
  )

  page.wait_for_selector('#plan-list .card')
  simple_stay_card = page.SS('#plan-list .card').find do |card|
    card.evaluate('(el) => el.textContent').strip.include?('素泊まり')
  end
  new_page = await_all(
    resolvable_future { |f| page.once('popup') { |new_page| f.fulfill(new_page) } },
    simple_stay_card.S('.btn').async_click,
  ).first

  new_page.emulate(Puppeteer::Devices.iPhone_X)
  new_page.wait_for_selector('input[name="term"]')
  new_page.click('input[name="term"]')
  new_page.keyboard do
    3.times { press("ArrowRight") }
    down("Shift")
    3.times { press("ArrowLeft") }
    up("Shift")
    press("5")
    press("Tab")
    press("2")
    press("Tab")
    press("Tab")
    press("Space")
  end
  new_page.click('input[name="username"]')
  new_page.keyboard.type_text("puppeteer")
  new_page.select('select[name="contact"]', "email")
  new_page.wait_for_selector('input[name="email"]')
  new_page.click('input[name="email"]');
  new_page.keyboard do
    type_text("puppeteer@example.com")
    press("Tab")
    type_text('Automation with puppeteer-ruby')
  end

  await_all(
    new_page.async_wait_for_navigation,
    new_page.async_click('#submit-button'),
  )

  new_page.wait_for_xpath('//button[text() = "この内容で予約する"]')
  new_page.Sx('//button[text() = "この内容で予約する"]').first.click

  new_page.screenshot(path: '4.hotel.testplanisphere.reservation_screen.png')
end
