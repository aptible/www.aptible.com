require 'fog'

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

# If ENV flag is set, reload the browser when files change
activate :livereload, host: 'localhost' if ENV['ENABLE_LIVERELOAD']

#
# Page options, layouts, aliases and proxies
#
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

#
# Blog
#
page '/blog/*', layout: 'post.haml'
# See /source/feed.xml.builder
page '/feed.xml', layout: false

#
# Changelog
#
page '/changelog/*', layout: 'post.haml'

# Authors
# Requires the site to be "ready" to read from the sitemap resources
ready do
  # Create dynamic pages for each blog post author
  by_author = sitemap.resources
                     .select { |p| p.data['section'] == 'Blog' }
                     .group_by { |p| p.data['author_id'] }
  by_author.each do |author|
    author_id = author[0]
    # lists their posts by date
    posts = author[1]
            .select { |p| p.data['author_id'] == author_id }
            .sort_by { |p| p.data['posted'] }.reverse!
    page "/blog/authors/#{author[0]}.html"
    proxy "/blog/authors/#{author[0]}.html", '/blog/author.html',
          locals: { author_id: author[0], posts: posts },
          ignore: true
  end
end

#
# contentful resources
#
page '/resources/index.html', layout: 'layout.haml'
page '/resources/*', layout: 'resource.haml'

#
# Legal
#
# Proxy /legal/index to Terms of Service
page '/legal/*', layout: 'legal.haml'
proxy '/legal/index.html', '/legal/terms-of-service.html'

# Pagination
#
# Why we can't use the middleman-pagination gem
# - doesn't paginate middleman resources (files in a directory), only data files
# - doesn't do page links, only prev, next, first, last... not 1,2,3,4
# - limited path configuration, ends up needing proxy config
ready do
  posts_per_page = 10
  all_posts = blog_and_grouped_changelog_posts
  subsets = paginated_subsets(all_posts, posts_per_page)
  number_of_pages = total_pages(all_posts.count, posts_per_page)
  page_links = page_links(number_of_pages, '/blog')

  subsets.each_with_index do |subset, index|
    current_page = index + 1
    proxy "#{page_links[index]}index.html", '/blog/posts.html',
          locals: {
            all_posts: all_posts,
            current_page: current_page,
            page_links: page_links,
            posts: subset
          }
  end
end
