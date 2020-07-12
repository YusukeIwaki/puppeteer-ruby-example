require 'puppeteer'
require 'open-uri'

open('https://developers.google.com/web/tools/images/puppeteer.png') do |f|
  content_type = f.content_type
  data = f.read

  Puppeteer.launch(headless: false, slow_mo: 50, args: ['--guest', '--window-size=1280,800']) do |browser|
    page = browser.pages.first || browser.new_page
    page.viewport = Puppeteer::Viewport.new(width: 1280, height: 800)

    page.goto('https://www.bing.com/images/search?q=microsoft+edge')

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

    page.reload
    page.screenshot(path: '6.request-interception.png')
  end
end
