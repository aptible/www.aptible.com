require 'fog'
require 'custom_mappers'

#
# Global Settings
#
set :markdown_engine, :redcarpet
set :markdown, fenced_code_blocks: true, smartypants: true, tables: true,
               strikethrough: true, with_toc_data: true
set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'
set :partials_dir, 'partials'
set :haml, ugly: true, format: :html5

# (Semi-) secrets
set :segmentio_writekey, ENV['SEGMENTIO_WRITEKEY'] || 'cn8oifbk6o'
set :swiftype_key, ENV['SWIFTYPE_KEY'] || 'dsMEc1fYviE2ShXAjYMW'
set :swiftype_engine, ENV['SWIFTYPE_ENGINE'] || 'axuhZ5Lt1ZUziN-DqxnR'
set :base_url, ENV['BASE_URL'] || 'https://www.aptible.com'

#
# Extensions
#
activate :syntax, line_numbers: true, wrap: true
activate :relative_assets
activate :directory_indexes

# Build-specific configuration
configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :asset_hash
end

# Contentful
activate :contentful do |f|
  f.space = { aptible: '8djp5jlzqrnc' }
  # rubocop:disable LineLength
  f.access_token = ENV['CONTENTFUL_KEY'] || 'b66d39f51cfcc747ca3af1b7731bd00cf877b659d69514845ba837ddae473605'
  # rubocop:enable LineLength
  # Use preview (draft) content everywhere EXCEPT production
  f.use_preview_api = ENV['CONTENTFUL_ENV'] != 'production'
  f.all_entries = true
  f.cda_query = { include: 3 }
  f.content_types = {
    blog_posts: {
      id: 'blogPost',
      mapper: CustomMappers::BlogPostMapper
    },
    employees: 'employee',
    customers: 'customer',
    customer_stories: 'customerStories'
  }
  puts ''
  puts "Activating Contentful Access Token with preview? ${f.use_preview_api}"
  puts ''
end

# Note: S3 Redirect does not work with Middleman v4
activate :s3_redirect do |config|
  config.bucket = ENV['S3_BUCKET'] || 'www.aptible-staging.com'
  config.region = 'us-east-1'
  config.after_build = false
end

data.redirects.each do |item|
  redirect item['loc'], item['url']

  # Zendesk will sometimes index slugged URLs by ID alone
  # e.g. /hc/en-us/categories/200178460-Getting-Started ->
  #      /hc/en-us/categories/200178460
  match = item['loc'].match(/(^.*[0-9]{9})/)
  redirect(match[1], item['url']) if match
end

# In development, reload the browser when files change
configure :development do
  activate :livereload, host: 'localhost'
end

#
# Page options, layouts, aliases and proxies
#
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

#
# Blog
#
page '/blog/*', layout: 'blog_post.haml'
# See /source/feed.xml.builder
page '/feed.xml', layout: false

# Authors
# Requires the site to be "ready" to read from the sitemap resources
ready do
  # Create dynamic pages for each blog post author
  by_author = sitemap.resources
  begin
    by_author.concat(data.aptible.blog_posts.values)
    by_author = by_author.select { |p| p.data['section'] == 'Blog' }
                         .group_by { |p| p.data['author_id'] }
    by_author.each do |author|
      author_id = author[0]
      # lists their posts by date
      posts = author[1]
              .select { |p| p.data['author_id'] == author_id }
              .sort_by { |p| p.data['posted'] }.reverse!
      page "/blog/authors/#{author[0]}.html", layout: 'blog_posts.haml'
      proxy "/blog/authors/#{author[0]}.html", '/blog/author.html',
            locals: { author_id: author[0], posts: posts }
    end
  rescue
    # This should not happen on a published post which requires an author, but
    # draft posts can be saved without one
    puts 'Contentful Data Error: Ensure all draft blog posts have an author'
  end
end

#
# contentful blog posts
#
if data.respond_to?('aptible') && !data.aptible.blog_posts.nil?
  data.aptible.blog_posts.values.each do |post|
    proxy "/blog/#{post.slug}/index.html",
          '/blog/post.html',
          locals: {
            cms_post: post,
            path: "/blog/#{post.slug}/index.html"
          },
          ignore: true
  end
end

#
# resources
#
page '/resources/*', layout: 'resource.haml'
page '/resources/index.html', layout: 'layout.haml'

#
# Legal
#
# Proxy /legal/index to Terms of Service
page '/legal/*', layout: 'legal.haml'
proxy '/legal/index.html', '/legal/terms-of-service.html'

# Topics (Support)
data.topics.each do |title, category|
  category_url = "/support/topics/#{category.slug}"
  page "#{category_url}/index.html", layout: 'layout.haml'
  proxy "#{category_url}/index.html",
        'support/topics/category.html',
        locals: { category: category, title: title },
        ignore: true do
    @title = title
    @category = category
    @description = category.header
  end

  category.articles.each do |article|
    page "support/topics/#{article.url}.html",
         layout: 'support-document.haml', hidden: article.hidden do
      @category_url = category_url
      @category_title = title
      @title = article.title
      @description = 'Aptible support guides and answers'
      @og_type = 'article'
    end
  end
end

# Quickstart Guides
# Middleman Data Files: https://middlemanapp.com/advanced/data_files/
data.quickstart.each do |language_name, language_data|
  language_data[:name] = language_name
  language_url = "/support/quickstart/#{language_data.slug}"
  proxy "#{language_url}/index.html",
        'support/quickstart/category.html',
        locals: { language: language_data },
        ignore: true do
    @title = "#{language_data.name} Quickstart Guides"
    @description = "Guides for getting started with #{language_data.name} "\
                   'on Aptible'
  end

  language_data.articles.each do |article|
    page "support/quickstart/#{article.url}.html",
         layout: 'support-document.haml' do
      @framework = article.framework
      @language = language_data
      @title = "#{@framework} Quickstart"
      @description = 'Step-by-step instructions for getting started '\
                     "with #{@framework} on Aptible"
      @og_type = 'article'
    end
  end
end
