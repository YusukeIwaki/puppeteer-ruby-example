require 'puppeteer'

username = ENV.fetch("PUP_SAMPLE_3_USERNAME", "myuser")
password = ENV.fetch("PUP_SAMPLE_3_PASSWORD", "mypassword")

# NOTE: Site UI was updated in 2026. Selectors have been updated accordingly.
Puppeteer.launch(headless: false, slow_mo: 120, args: ['--guest', '--window-size=1280,800']) do |browser|
  page = browser.pages.first || browser.new_page
  page.viewport = Puppeteer::Viewport.new(width: 1280, height: 800)
  page.goto("https://www.viewsnet.jp/default.aspx", wait_until: 'networkidle2', timeout: 60000)

  puts "Input username and password"
  # Wait for the login form
  page.wait_for_selector('#id', timeout: 30000)

  # Input service ID
  page.click('#id')
  page.keyboard.type_text(username)

  # Move to password field and input password
  page.keyboard.press("Tab")
  page.keyboard.type_text(password)

  puts "Press Tab twice and Enter to login"
  page.keyboard.press("Tab")
  page.keyboard.press("Tab")
  page.wait_for_navigation do
    page.keyboard.press("Enter")
  end

  page.screenshot(path: "3.login_and_capture_screen.png")
end
