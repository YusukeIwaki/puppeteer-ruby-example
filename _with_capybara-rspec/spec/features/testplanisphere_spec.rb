require 'spec_helper'

RSpec.describe 'hotel.testplanisphere.dev', type: :feature do
  before {
    visit 'https://hotel.testplanisphere.dev/'
    @browser = Puppeteer.connect(
                browser_url: 'http://localhost:9222',
                default_viewport: Puppeteer::Viewport.new(width: 1280, height: 800))
  }

  after {
    @browser.disconnect
  }

  it 'can be handled with puppeteer and assert with Capybara' do
    # automation with puppeteer >>
    puppeteer_page = @browser.pages.first
    puppeteer_page.wait_for_selector('li.nav-item')

    reservation_link = puppeteer_page.SS('li.nav-item')[1]

    await_all(
      puppeteer_page.async_wait_for_navigation,
      reservation_link.async_click,
    )
    # << automation with puppeteer

    # expectation with Capybara DSL
    expect(page.title).to include('宿泊プラン一覧')
    expect(page).to have_text('宿泊プラン一覧')
  end

  it 'can be handled with Capybara and assert with puppeteer' do
    # automation with Capybara >>
    page.all('li.nav-item')[1].click
    # << automation with Capybara

    # expectation with puppeteer
    puppeteer_page = @browser.pages.first
    expect(puppeteer_page.title).to include('宿泊プラン一覧')
    body_text = puppeteer_page.Seval('body', '(el) => el.textContent')
    expect(body_text).to include('宿泊プラン一覧')
  end
end
