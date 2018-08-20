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
set :clearbit_key, ENV['CLEARBIT_KEY'] || 'pk_59fa328b8fcd77780586aae05ea45858'
set :base_url, ENV['BASE_URL'] || 'https://www.aptible.com'
set :base_doc_url, ENV['BASE_DOC_URL'] || 'https://www.aptible.com'

#
# Extensions
#
activate :syntax, line_numbers: true, wrap: true
activate :relative_assets
activate :directory_indexes

# Build-specific configuration
configure :build do
  activate :minify_css

  # aptible.js is minified by webpack, and is called by URL from paid landing
  # pages, so don't hash the filename
  activate :minify_javascript, ignore: ['aptible.js']
  activate :asset_hash, ignore: ['aptible.js']

  #
  # Ignore pages with `published: false` frontmatter
  #
  unless ENV['CONTENTFUL_PREVIEW_MODE']
    ready do
      unpublished = sitemap.resources.select do |item|
        !item.metadata[:page].fetch('published', true)
      end

      if unpublished
        unpublished.each do |ignored_page|
          ignore ignored_page.path
        end
      end
    end
  end
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
page '/hipaa/*', layout: :compliance_hipaa
page '/hipaa/regulation/*', layout: :compliance_hipaa_regulation
page '/gdpr/*', layout: :compliance_gdpr
page '/gdpr/regulation/*', layout: :compliance_gdpr_regulation

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

# Pre-calculate prev, next, and parent links for regulation sections
ready do
  [:hipaa, :gdpr].each do |protocol|
    data[protocol][:flattened] = []

    data[protocol].regulation.each do |part|
      part.subparts.each do |subpart|
        subpart.subparts.each do |regulation|
          regulation[:parents] = [part, subpart]
          data[protocol].flattened << regulation
        end
      end
    end

    data[protocol][:precalculated] = {}
    data[protocol].flattened.each_with_index do |regulation, regulation_idx|
      if regulation_idx > 0
        regulation[:previous] = data[protocol].flattened[regulation_idx - 1]
      end

      if regulation_idx < data[protocol].flattened.length - 1
        regulation[:next] = data[protocol].flattened[regulation_idx + 1]
      end

      data[protocol].precalculated[regulation.url] = regulation
    end
  end
end
