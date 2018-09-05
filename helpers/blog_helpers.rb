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

  def blog_posts_for_feed
    section_pages('Blog').sort_by { |p| -p.data['posted'].to_time.to_i }
  end

  def blog_posts
    section_pages('Blog')
      .select { |p| p.data['type'] == 'blog post' }
      .sort_by { |p| -p.data['posted'].to_time.to_i }
  end

  def latest_blog_post
    blog_posts_for_feed.first
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

  #
  # Social Share Link Helpers
  #
  def post_share_href(post)
    "#{base_url}#{blog_post_href(post)}"
  end

  def post_facebook_share_href(post)
    facebook_share_href(post_share_href(post))
  end

  def post_twitter_share_href(post)
    twitter_share_href(post_share_href(post), post.data.title)
  end

  def post_linkedin_share_href(post)
    linkedin_share_href(
      post_share_href(post),
      post.data.title,
      post.data.excerpt
    )
  end

  def post_hackernews_share_href(post)
    hackernews_share_href(post_share_href(post), post.data.title)
  end

  def post_mailto_share_href(post)
    mailto_share_href(post_share_href(post), post.data.title, post.data.excerpt)
  end
end
