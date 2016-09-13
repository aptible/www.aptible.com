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

  def blog_posts_by_date
    sitemap.resources
           .select { |p| p.data['section'] == 'Blog' }
           .sort_by { |p| p.data['posted'] }.reverse!
  end

  def blog_post_path(resource)
    resource.eponymous_directory_path.chomp '/'
  end

  def dashboard_href
    'https://dashboard.aptible.com/login'
  end

  def contact_href
    # 'https://aptible.zendesk.com/hc/en-us/requests/new'
    'http://contact.aptible.com'
  end
end
