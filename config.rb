require 'fog'
require 'cgi'

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page "/path/to/file.html", layout: :otherlayout

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

set :markdown_engine, :redcarpet
set :markdown, fenced_code_blocks: true, smartypants: true, tables: true
set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'
set :partials_dir, 'partials'

# (Semi-) secrets
set :segmentio_writekey, ENV['SEGMENTIO_WRITEKEY'] || 'cn8oifbk6o'
set :swiftype_key, ENV['SWIFTYPE_KEY'] || 'dsMEc1fYviE2ShXAjYMW'
set :swiftype_engine, ENV['SWIFTYPE_ENGINE'] || 'axuhZ5Lt1ZUziN-DqxnR'
set :base_url, ENV['BASE_URL'] || 'https://www.aptible.com'

activate :syntax, line_numbers: true
activate :directory_indexes

# Topics (Support)
data.topics.each do |title, category|
  category_url = "/support/topics/#{category.slug}"
  page "#{category_url}/index.html", layout: 'topics.haml'
  proxy "#{category_url}/index.html",
        'support/topics/category.html',
        locals: { category: category, title: title },
        ignore: true do
    @description = "Aptible support questions about #{title}"
  end

  category.articles.each do |article|
    page "support/topics/#{article.url}.html",
         layout: 'topics.haml', hidden: article.hidden do
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
    page "support/quickstart/#{article.url}.html", layout: 'quickstart.haml' do
      @framework = article.framework
      @language = language_data
      @title = "#{@framework} Quickstart"
      @description = 'Step-by-step instructions for getting started '\
                     "with #{@framework} on Aptible"
      @og_type = 'article'
    end
  end
end

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end

# Build-specific configuration
configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :asset_hash
end

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

helpers do
  def title_tags(opts = {})
    current_page = opts[:page]

    # Article pages pass @title as an option
    title = opts[:title]

    # Some pages also set it in front matter
    title ||= current_page.metadata[:locals][:title] ||
              current_page.data.header_title

    # Some pages just have a default title, which we don't want to repeat
    if title.nil? || title == 'Aptible Support'
      swiftype_title = title = 'Aptible Support'
    else
      # Use a clean title for Swifttype
      swiftype_title = title
      title = "#{title} | Aptible Support"
    end

    title = CGI.escapeHTML(title) if title
    swiftype_title = CGI.escapeHTML(swiftype_title) if swiftype_title

    "<title>#{title}</title> \n" \
    "<meta property=\"og:title\" content=\"#{title}\" > \n" \
    "<meta class=\"swiftype\" name=\"title\" " \
    "data-type=\"string\" content=\"#{swiftype_title}\" >"
  end

  def meta_tags(opts = {})
    description = opts[:description]
    og_type = opts[:og_type]

    description ||= current_page.data.header_subtitle
    description = CGI.escapeHTML(description) if description

    url = "#{base_url}#{current_page.url}"

    og_type = og_type.nil? ? 'website' : 'article'

    "<meta property=\"og:description\" content=\"#{description}\" >\n" \
    "<meta property=\"og:url\" content=\"#{url}\" >\n"\
    "<meta property=\"og:type\" content=\"#{og_type}\" >"
  end

  def contact_href
    'https://aptible.zendesk.com/hc/en-us/requests/new'
  end
end
