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
      .select { |p| p.data['type'] == 'blog post' }
      .sort_by { |p| -p.data['posted'].to_time.to_i }
  end

  def latest_blog_post
    blog_posts.first
  end

  # combines blog posts and change log posts grouped by month/year
  def blog_and_grouped_changelog_posts
    all_posts = blog_posts + changelog_posts_grouped.values
    all_posts.sort_by do |p|
      # If the post is a changelog group, sort by the first post in the group
      p = p.first if p.is_a?(Array)
      -p.data['posted'].to_time.to_i
    end
  end
end
