xml.instruct!
xml.feed xmlns: 'http://www.w3.org/2005/Atom' do
  xml.title 'Aptible Blog'
  xml.subtitle 'Posts detailing feature updates, compliance resources, and information useful to users of Aptible\'s security and DevOps tools.'
  xml.id 'https://www.aptible.com/blog'
  xml.link rel: 'alternate', type: 'text/html', hreflang: 'en', href: 'https://www.aptible.com/'
  xml.link href: 'https://www.aptible.com/blog'
  xml.link href: 'https://www.aptible.com/feed.xml', rel: 'self'
  xml.updated latest_blog_post.data.posted.to_time.iso8601
  xml.author { xml.name 'Aptible Blog RSS' }
  blog_posts_by_date[0..10].each do |post|
    file = File.open(post.source_file, 'r')
    content = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new()).render file.read
    xml.entry do
      xml.title post.data.title
      xml.link 'rel' => 'alternate', 'href' => post.url
      xml.id post.url
      xml.published post.data.posted.to_time.iso8601
      xml.updated post.data.posted.to_time.iso8601
      xml.author { xml.name 'Aptible' }
      xml.summary post.data.excerpt, 'type' => 'html'
      xml.content content, 'type' => 'html'
    end
  end
end
