require 'puppeteer'

username = ENV.fetch("PUP_SAMPLE_3_USERNAME", "myuser")
password = ENV.fetch("PUP_SAMPLE_3_PASSWORD", "mypassword")

Puppeteer.launch(headless: false, slow_mo: 120, args: ['--guest']) do |browser|
  page = browser.pages.first
  page = page || browser.new_page
  page.emulate(Puppeteer::Devices.iPhone_8)
  page.goto("https://www.jreast.co.jp/card/sp/servicelist/viewsnet/login.html")

  puts "Press 'Login'"

  await_all(
    page.async_click(".views_login .loginbtn"),
    page.async_wait_for_navigation,
  )

  puts "Input username and password"
  page.click("#TxtViewsNetId");
  page.keyboard.type_text(username);
  page.keyboard.press("Tab");
  page.keyboard.type_text(password);
  await_all(
    page.keyboard.async_press("Enter"),
    page.async_wait_for_navigation
  )

  page.screenshot(path: "3.login_and_capture_screen.png")
end
