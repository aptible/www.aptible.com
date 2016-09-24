module AptibleHelpers
  def quickstart?(url)
    url.include? 'support/quickstart'
  end

  def support_topic?(url)
    url.include? 'support/topics'
  end

  def post_date(string_date)
    string_date.strftime('%B %e, %Y')
  end

  def latest_blog_post
    blog_posts_by_date.first
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

  def resource_link_path(resource)
    '/' + resource.eponymous_directory_path.chomp('/')
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
