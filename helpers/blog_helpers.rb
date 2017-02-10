module BlogHelpers
  def blog_post_author_href(post)
    "/blog/authors/#{post.data.author_id}"
  end

  def blog_post_href(post)
    # Contentful posts are a Thor Hash, others are Middleman Sitemap Resources
    return "/blog/#{post.slug}/" if post.is_a?(Hash)
    post.url
  end

  def blog_posts_oldest_first
    mm_posts = sitemap.resources.select { |p| p.data['section'] == 'Blog' }
    cms_posts = data.aptible.blog_posts.values
    (mm_posts + cms_posts).sort_by { |p| p.data['posted'] }
  end

  def blog_posts_newest_first
    blog_posts_oldest_first.reverse!
  end

  def latest_blog_post
    blog_posts_newest_first.first
  end

  def index_of_post(post)
    blog_posts_oldest_first.index do |p|
      blog_post_href(p) == blog_post_href(post)
    end
  end

  def prev_post(current_post)
    if index_of_post(current_post).positive?
      return blog_posts_oldest_first.at(index_of_post(current_post) - 1)
    end
    nil
  end

  def next_post(current_post)
    blog_posts_oldest_first.at index_of_post(current_post) + 1
  end

  def post_date(string_date)
    string_date.strftime('%B %e, %Y')
  end
end
