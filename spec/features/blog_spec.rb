require 'spec_helper'

describe 'blog index', type: :feature do
  before do
    visit '/blog/'
  end

  xit 'includes Aptible Blog in the page title' do
    expect(page.title).to include 'Aptible Blog'
  end
end
