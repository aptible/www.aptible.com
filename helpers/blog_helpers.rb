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

  def facebook_share_href(post)
    url = URI.escape(post_share_href(post))
    "https://www.facebook.com/sharer/sharer.php?u=#{url}"
  end

  def twitter_share_href(post)
    title = URI.escape("#{post.data.title} @aptible")
    url = URI.escape(post_share_href(post))

    "https://twitter.com/intent/tweet?original_referer=#{url}" \
      "&ref_src=twsrc%5Etfw&text=#{title}&tw_p=tweetbutton&url=#{url}"
  end

  def linkedin_share_href(post)
    title = URI.escape(post.data.title)
    url = URI.escape(post_share_href(post))
    excerpt = URI.escape(post.data.excerpt)

    'https://www.linkedin.com/shareArticle?mini=true' \
      "&url=#{url}&title=#{title}&summary=#{excerpt}"
  end

  def hackernews_share_href(post)
    title = URI.escape(post.data.title)
    url = URI.escape(post_share_href(post))
    "http://news.ycombinator.com/submitlink?u=#{url}&t=#{title}"
  end

  def mailto_share_href(post)
    body = <<-BODY
#{post.data.excerpt}

#{post_share_href(post)}
BODY
    "mailto:?subject=#{URI.escape(post.data.title)}&body=#{URI.escape(body)}"
  end
end
