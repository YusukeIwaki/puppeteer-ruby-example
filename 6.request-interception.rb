require 'puppeteer'
require 'open-uri'

# Ruby 3.0+ requires URI.open instead of open
# Using Puppeteer logo from GitHub
URI.open('https://user-images.githubusercontent.com/10379601/29446482-04f7036a-841f-11e7-9872-91d1fc2ea683.png') do |f|
  content_type = f.content_type
  data = f.read

  Puppeteer.launch(headless: false, slow_mo: 50, args: ['--guest', '--window-size=1280,800']) do |browser|
    page = browser.pages.first || browser.new_page
    page.viewport = Puppeteer::Viewport.new(width: 1280, height: 800)

    # Use a simpler site with images
    page.goto('https://en.wikipedia.org/wiki/Puppeteer_(software)', wait_until: 'networkidle2', timeout: 60000)

    # Replace all images with Puppeteer logo :)
    page.request_interception = true
    page.on 'request' do |req|
      if req.resource_type == 'image'
        req.respond(
          content_type: content_type,
          body: data,
        )
      else
        req.continue
      end
    end

    page.reload(wait_until: 'networkidle2', timeout: 60000)
    page.screenshot(path: '6.request-interception.png')
  end
end
