require 'puppeteer'

launch_options = {
  executable_path: ENV['PUPPETEER_EXECUTABLE_PATH'],
  args: ['--no-sandbox'],
}
Puppeteer.launch(**launch_options) do |browser|
  page = browser.pages.first || browser.new_page
  page.goto("https://github.com/YusukeIwaki")
  page.screenshot(path: "1.capture_a_site_chromium.png")
end
