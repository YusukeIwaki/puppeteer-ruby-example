# puppeteer-ruby Examples

A collection of sample code for the puppeteer-ruby gem.

## Installing Dependencies

```bash
bundle install
```

## Sample Execution and Status

### 1. capture_a_site.rb (Working)
Captures a screenshot of a GitHub profile page.

```bash
bundle exec ruby 1.capture_a_site.rb
```

Output: `1.capture_a_site.png`

### 2. simple_scraping.rb (Working)
Scraping sample that extracts repository names from GitHub search results.

```bash
bundle exec ruby 2.simple_scraping.rb
```

**Note**: Updated to navigate directly to search results URL due to GitHub UI changes.

### 3. login_and_capture_screen.rb (Site Error - Requires Credentials)
Authentication sample for VIEW's NET login page.

```bash
source .envrc && bundle exec ruby 3.login_and_capture_screen.rb
```

Output: `3.login_and_capture_screen.png`

**Notes**:
- Requires environment variables `PUP_SAMPLE_3_USERNAME` and `PUP_SAMPLE_3_PASSWORD`
- Selector updated to `#id` due to site UI changes in 2026
- Login succeeds but destination page returns ERR_HTTP2_PROTOCOL_ERROR (site-side issue)

### 4. hotel.testplanisphere.reservation.rb (Working)
Automated hotel reservation sample.

```bash
bundle exec ruby 4.hotel.testplanisphere.reservation.rb
```

Output: `4.hotel.testplanisphere.reservation_screen.png`

**Note**: Site URL migrated to `https://hotel-example-site.takeyaqa.dev/ja/`

### 5. element-to-pdf.rb (Working)
Converts a GitHub user's contribution graph to PDF.

```bash
bundle exec ruby 5.element-to-pdf.rb
```

Output: `5.element-to-pdf.github.pdf`

### 6. request-interception.rb (Working)
Request interception sample that replaces images.

```bash
bundle exec ruby 6.request-interception.rb
```

Output: `6.request-interception.png`

**Notes**:
- Updated to use `URI.open` instead of `open` for Ruby 3.0+ compatibility
- Changed to Wikipedia site

### 7. with_browserless.io.rb (Working - Requires API Token)
Connects to a remote browser using browserless.io.

```bash
source .envrc && bundle exec ruby 7.with_browserless.io.rb
```

Output: `7.with_browserless.io.png`

**Notes**:
- Requires environment variable `BROWSERLESS_IO_API_TOKEN`
- Protocol error warnings may appear during execution, but screenshots are generated successfully

## Additional Sample Directories

### examples_in_ferrum/
puppeteer-ruby samples written in Ferrum library style.

```bash
bundle exec ruby examples_in_ferrum/1.Navigate_to_a_website_and_save_a_screenshot.rb
bundle exec ruby examples_in_ferrum/3.Evaluate_some_JavaScript_and_get_full_width_height.rb
bundle exec ruby examples_in_ferrum/4.Do_any_mouse_movements_you_like.rb
```

**Notes**:
- Sample 2 needs fixes due to Google UI changes (search box changed from `input` to `textarea`)
- Output files are generated in the current directory

### docker_chromium/
Samples using Chromium inside Docker.

```bash
cd docker_chromium
docker build -t puppeteer-ruby-chromium .
docker run --rm -v "$(pwd):/app" puppeteer-ruby-chromium ruby 1.capture_a_site_chromium.rb
docker run --rm -v "$(pwd):/app" puppeteer-ruby-chromium ruby 4.hotel.testplanisphere.reservation_chromium.rb
```

Output:
- `1.capture_a_site_chromium.png`
- `4.hotel.testplanisphere.reservation_chromium.png`

**Notes**:
- Requires Docker environment
- Dockerfile updated (using font-noto-cjk package, fixed ENV syntax)
- URL updated to `https://hotel-example-site.takeyaqa.dev/ja/`

### _with_capybara-rspec/
Test samples combining Capybara + RSpec + Selenium + Puppeteer.

```bash
cd _with_capybara-rspec
bundle install
bundle exec rspec
```

**Notes**:
- Requires additional gems: selenium-webdriver, capybara, rspec
- URL updated to `https://hotel-example-site.takeyaqa.dev/ja/`
- ChromeDriver version warnings may appear, but tests work correctly

## Troubleshooting

### Timeout Errors
When accessing external sites times out, adjust the `wait_until` and `timeout` options.

```ruby
page.goto(url, wait_until: 'networkidle2', timeout: 60000)
```

### Selector Not Found Errors
Selectors may be outdated due to external site UI changes.
Use Playwright MCP to check the current site structure and update selectors.

```bash
# Check with Playwright MCP
mcp__playwright__browser_navigate to access the site
mcp__playwright__browser_snapshot to check DOM structure
```

### Ruby 3.0+ Compatibility
When using `open-uri`, use `URI.open` instead of `open`.

## How to Verify Samples

You can verify all samples by asking Claude Code:

```
Please verify that the samples in this repository work correctly
```

Verification flow:
1. Install dependencies with `bundle install`
2. Run each sample with `bundle exec ruby <filename>`
3. Verify that output files (PNG/PDF) are generated
4. If errors occur, use Playwright MCP to check site DOM structure and fix selectors

## Verification History

### January 24, 2026
- Environment: macOS (Darwin 24.6.0), Ruby 3.2.9, puppeteer-ruby 0.45.6
- Root sample results:
  - Samples 1, 2, 4, 5, 6: Working
  - Sample 3: Selector fixed to `#id`. Login succeeds but site returns HTTP2 error
  - Sample 7: Working (warnings appear but screenshot generated successfully)
- Additional directory results:
  - examples_in_ferrum: 1, 3, 4 working / 2 needs fixes due to Google UI changes
  - docker_chromium: 1, 4 working (verified with Docker build and run)
  - _with_capybara-rspec: Working (2 examples, 0 failures)
- Changes made:
  - 3.login_and_capture_screen.rb: Changed selector to `#id`
  - examples_in_ferrum/2.Interact_with_a_page.rb: Changed search box to `textarea[name="q"]`
  - docker_chromium/Dockerfile: Using font-noto-cjk package, fixed ENV syntax
  - docker_chromium/4.hotel.testplanisphere.reservation_chromium.rb: URL updated
  - _with_capybara-rspec/spec/features/testplanisphere_spec.rb: URL updated

### January 24, 2025
- Initial verification
