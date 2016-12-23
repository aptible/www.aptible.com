require 'spec_helper'

describe 'robots.txt', type: :feature do
  describe 'on any environment' do
    before do
      visit '/robots.txt'
    end

    it 'accepts all user agents' do
      expect(page.html).to include('User-agent: *')
    end

    it 'includes a sitemap reference' do
      expect(page.html).to include('Sitemap: https://www.aptible.com/sitemap.xml')
    end
  end

  describe 'when served from anywhere but production www' do
    it 'includes a disallow all (root) directive' do
      Capybara.app.config[:base_url] = 'http://testing.example.com'
      visit '/robots.txt'
      expect(page.html).to include('Disallow: /')
    end
  end

  describe 'when served from https://www.aptible.com' do
    it 'does not include a disallow directive' do
      Capybara.app.config[:base_url] = 'https://www.aptible.com'
      visit '/robots.txt'
      expect(page.html).to_not include('Disallow: /')
    end
  end
end
