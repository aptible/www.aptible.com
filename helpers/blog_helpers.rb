module BlogHelpers
  def blog_post_author_href(post)
    "/blog/authors/#{post.data.author_id}"
  end

  # TODO: Figure out Rouge syntax fenced code blocks
  def render_markdown(markdown)
    render_options = {
      filter_html: true,
      hard_wrap: true,
      link_attributes: { rel: 'nofollow' },
      prettify: true
    }
    extensions = {
      smarypants: true,
      fenced_code_blocks: true,
      trables: true,
      strikethrough: true,
      with_toc_data: true
    }
    renderer = Redcarpet::Render::HTML.new(render_options)
    Redcarpet::Markdown.new(renderer, extensions).render(markdown).html_safe
  end

  def author_gravatar(post)
    hash = Digest::MD5.hexdigest(post.data.author_email)
    "https://www.gravatar.com/avatar/#{hash}"
  end

  def blog_post_href(post)
    post.url
  end

  def blog_posts_oldest_first
    posts = sitemap.resources.select { |p| p.data['section'] == 'Blog' }
    posts.sort_by { |p| p.data['posted'] }
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
