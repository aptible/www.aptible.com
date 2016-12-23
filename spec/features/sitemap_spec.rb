require 'spec_helper'

describe 'sitemap.xml', type: :feature do
  before do
    visit '/sitemap.xml'
  end

  it 'has an XML doctype' do
    page.html.should include('<?xml version="1.0" encoding="UTF-8"?>')
  end

  it 'excludes the ui-kit' do
    page.should_not have_content(/ui-kit/)
  end

  it 'lists all pages in the site' do
    page.should have_content(/blog|company|customers|enclave|faq|gridiron|supprt/)
  end
end
