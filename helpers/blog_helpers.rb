module BlogHelpers
  def latest_blog_post
    blog_posts_by_date.first
  end

  def blog_post_author_href(post)
    "/blog/authors/#{post.data.author_id}"
  end

  def blog_posts_by_date
    sitemap.resources
           .select { |p| p.data['section'] == 'Blog' }
           .sort_by { |p| p.data['posted'] }.reverse!
  end

  def prev_post(current_post)
    ordered_posts = blog_posts_by_date
    current = ordered_posts.index { |p| p.path == current_post.path }
    current > 0 ? ordered_posts.at(current - 1) : nil
  end

  def next_post(current_post)
    ordered_posts = blog_posts_by_date
    current = ordered_posts.index { |p| p.path == current_post.path }
    ordered_posts.at current + 1
  end

  def post_date(string_date)
    string_date.strftime('%B %e, %Y')
  end
end
