require 'puppeteer'

Puppeteer.launch(slow_mo: 50, headless: true) do |browser|
  page = browser.pages.first || browser.new_page
  page.viewport = Puppeteer::Viewport.new(width: 1200, height: 800, device_scale_factor: 2)

  username = 'AndroidDev'
  searchable = true

  page.goto("https://twitter.com/#{username}")
  page.wait_for_selector("article")
  page.Seval("article", "tweet => tweet.click()")
  page.wait_for_selector 'article', visible: true

  overlay = page.S('article')

  if searchable
    js = <<-JAVASCRIPT
    tweet => {
      const width = getComputedStyle(tweet).width;
      tweet = tweet.cloneNode(true);
      tweet.style.width = width;
      document.body.innerHTML = `
        <div style="display:flex;justify-content:center;align-items:center;height:100vh;">;
          ${tweet.outerHTML}
        </div>
      `;
    }
    JAVASCRIPT
    page.evaluate(js, overlay)
  else
    screenshot = overlay.screenshot(path: '5.element-to-pdf.tweet.png')

    require 'base64'
    page.content = <<-HTML
    <!DOCTYPE html>
    <html>
      <head>
        <style>
          html, body {
            height: 100vh;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            background: #fafafa;
          }
          img {
            max-width: 60%;
            box-shadow: 3px 3px 6px #eee;
            border-radius: 6px;
          }
        </style>
      </head>
      <body>
        <img src="data:img/png;base64,#{Base64.strict_encode64(screenshot)}">
      </body>
    </html>
    HTML
  end
  page.pdf(path: '5.element-to-pdf.tweet.pdf', print_background: true)
end
