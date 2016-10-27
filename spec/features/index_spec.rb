require 'spec_helper'

describe 'index', type: :feature do
  before do
    visit '/support'
  end

  it 'has a large search bar' do
    page.should have_selector '#search-form'
  end

  it 'has the correct page title' do
    page.should have_selector 'h1'
    within 'h1' do
      page.should have_content(/Aptible Support/)
    end
  end
end
