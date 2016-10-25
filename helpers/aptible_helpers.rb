require 'cgi'

module AptibleHelpers
  def page_title
    current_page.data.title || @title || 'Aptible'
  end

  def page_description
    description = current_page.data.description || @description ||
                  current_page.data.header_subtitle ||
                  current_page.data.excerpt || ''
    CGI.escapeHTML(description)
  end

  def page_image
    current_page.data.image || '/images/meta/page-image.png'
  end

  def page_url
    "#{base_url}#{current_page.url}"
  end

  def quickstart?(url)
    url.include? 'support/quickstart'
  end

  def support_topic?(url)
    url.include? 'support/topics'
  end

  def post_date(string_date)
    string_date.strftime('%B %e, %Y')
  end

  def active_nav_item(path)
    match = current_page.url.include?(path) || current_page.url == path
    match ? 'nav-item--active' : ''
  end

  def quickstart_index_href(language)
    if (language.articles && language.articles.count == 1) || !language.articles
      "/support/quickstart/#{language.url}"
    else
      "/support/quickstart/#{language.slug}"
    end
  end

  # Preserve the order of the supplied titles for the results
  def resources_by_title(titles)
    resources = []
    titles.each do |title|
      resources << sitemap.resources
                          .select { |p| p.data['title'] == title }.first
    end
    resources
  end

  def resource_subtitle(resource)
    subtitle = resource.data['categories'] || 'Blog'
    subtitle.is_a?(Array) ? subtitle.first : subtitle
  end

  def latest_blog_post
    blog_posts_by_date.first
  end

  def blog_post_author_href(post)
    "/blog/authors/#{post.data.author_id}"
  end

  def legal_sections
    sitemap.resources
           .select { |p| p.data['section'] == 'Legal' }
           .group_by { |p| p.data['sub_section'] }.keys.sort
  end

  def legal_section(sub_section)
    l = sitemap.resources
               .select do |p|
                 p.data['section'] == 'Legal' &&
                   p.data['sub_section'] == sub_section &&
                   p.url != '/legal/'
               end
    l.sort_by { |p| p.data['order'] }
  end

  def blog_posts_by_date
    sitemap.resources
           .select { |p| p.data['section'] == 'Blog' }
           .sort_by { |p| p.data['posted'] }.reverse!
  end

  def resources_by_category(category = 'all', featured = false)
    filtered = sitemap.resources.select { |r| r.data['section'] == 'Resources' }
    unless category == 'all'
      filtered = filtered.select { |r| r.data['categories'].include? category }
    end
    filtered.sort_by { |r| r.data['posted'] }.reverse!

    if featured
      filtered.select { |r| r.data.include? 'featured' }
    else
      filtered.select { |r| !r.data.include? 'featured' }
    end
  end

  def dashboard_href
    'https://dashboard.aptible.com/login'
  end

  def open_account_href
    'https://dashboard.aptible.com/signup'
  end

  def contact_href
    # 'https://aptible.zendesk.com/hc/en-us/requests/new'
    'http://contact.aptible.com'
  end
end
