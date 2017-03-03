require 'spec_helper'

describe 'index', type: :feature do
  before do
    visit '/blog'
  end

  it 'includes Aptible Blog in the page title' do
    expect(page.title).to include 'Aptible Blog'
  end
end
