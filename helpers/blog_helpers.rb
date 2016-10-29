module BlogHelpers
  def blog_post_author_href(post)
    "/blog/authors/#{post.data.author_id}"
  end

  def blog_posts_oldest_first
    sitemap.resources
           .select { |p| p.data['section'] == 'Blog' }
           .sort_by { |p| p.data['posted'] }
  end

  def blog_posts_newest_first
    blog_posts_oldest_first.reverse!
  end

  def latest_blog_post
    blog_posts_newest_first.first
  end

  def index_of_post(post)
    blog_posts_oldest_first.index { |p| p.path == post.path }
  end

  def prev_post(current_post)
    if index_of_post(current_post) > 0
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
