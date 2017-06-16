module BlogHelpers
  def blog_post_author_href(post)
    "/blog/authors/#{post.data.author_id}"
  end

  def author_gravatar(post)
    hash = Digest::MD5.hexdigest(post.data.author_email)
    "https://www.gravatar.com/avatar/#{hash}"
  end

  def blog_post_href(post)
    post.url
  end

  def blog_posts
    section_pages('Blog')
      .sort_by { |p| -p.data['posted'].to_time.to_i }
  end

  def latest_blog_post
    blog_posts.first
  end
end
