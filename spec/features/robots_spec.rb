ENV['BASE_URL'] = 'http://test.example.com'
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
    before do
      ENV['BASE_URL'] = 'http://test.example.com'
      Capybara.app = Middleman::Application.server.inst do
        set :root, File.expand_path(File.join(File.dirname(__FILE__), '..'))
        set :environment, :development
        set :show_exceptions, false
      end
    end
    it 'includes a disallow all (root) directive' do
      visit '/robots.txt'
      expect(page.html).to include('Disallow: /')
    end
  end

  describe 'when served from https://www.aptible.com' do
    before do
      ENV['BASE_URL'] = 'https://www.aptible.com'
      Capybara.app = Middleman::Application.server.inst do
        set :root, File.expand_path(File.join(File.dirname(__FILE__), '..'))
        set :environment, :development
        set :show_exceptions, false
      end
    end
    it 'does not include a disallow directive' do
      visit '/robots.txt'
      expect(page.html).to_not include('Disallow: /')
    end
  end
end
