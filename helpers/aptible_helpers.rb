require 'cgi'

module AptibleHelpers
  # Determine what the page title should be
  def page_title
    pg_title = current_page.data.title || @title || 'Aptible'
    if current_page.metadata[:locals] &&
       current_page.metadata[:locals][:cms_post]
      pg_title = current_page.metadata[:locals][:cms_post][:title]
    end
    if current_page.url.include?('/blog') && pg_title != 'Aptible Blog'
      return pg_title + ' | Aptible Blog'
    end
    pg_title
  end

  def page_description
    description = current_page.data.description || @description ||
                  current_page.data.header_subtitle ||
                  current_page.data.excerpt || ''
    CGI.escapeHTML(description)
  end

  def page_image
    img_src = current_page.data.image || 'meta/page-image.png'
    # Needs the fingerprinted filename from asset_path, but can't find an
    # absolute path option, hence this sad hack to replace `../`.
    "#{base_url}/#{asset_path(:images, img_src).gsub(%r{\.\.\/}, '')}"
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

  def resource_header_style(resource)
    if resource.header_image
      "background-image: url(#{resource.header_image});"
    else
      ''
    end
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

  def resources_oldest_first
    sitemap.resources
           .select { |r| r.data['section'] == 'Resources' }
           .sort_by { |r| r.data['posted'] }
  end

  def resources_newest_first
    resources_oldest_first.reverse!
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

  def status_href
    'http://status.aptible.com/'
  end
end
