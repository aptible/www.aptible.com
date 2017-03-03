require 'spec_helper'

describe 'index', type: :feature do
  before do
    visit '/'
  end

  it 'includes " | Aptible" in the page title' do
    expect(page.title).to include '| Aptible'
  end

  it 'has signup CTAs' do
    expect(page.all('form.signup-cta').count).to be > 1
  end
end
