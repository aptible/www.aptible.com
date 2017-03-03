shared_examples 'a valid page' do |article, _, path|
  before do
    visit "#{path}/#{article['url']}"
  end

  it 'should have a page title' do
    title = article['title']
    CGI.escapeHTML(title) if title
    expect(page).to have_title title
  end

  it 'should have a header' do
    page.assert_selector('header.aptible-header')
  end

  it 'should have a footer' do
    page.assert_selector('footer.aptible-footer')
  end

  it 'should have an h1' do
    page.assert_selector('h1')
  end

  it 'should have title content on page' do
    expect(page).to have_content article['title']
  end
end
