require 'redcarpet'
require 'rouge'
require 'rouge/plugins/redcarpet'
module BlogHelpers
  class HTML < Redcarpet::Render::HTML
    include Rouge::Plugins::Redcarpet
  end

  def blog_post_author_href(post)
    "/blog/authors/#{post.data.author_id}"
  end

  def blog_summary(post)
    if post.source_file
      body = File.open(post.source_file, 'r').read.split('---').last
    else
      body = post.body
    end
    if body.length > 500
      # body = body.sli
    end
    summary = body.slice(0..500) + "&hellip;"
    Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(config[:markdown])).render(summary)
  end

  def render_cms_markdown(post)
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
    renderer = HTML.new(render_options)
    Redcarpet::Markdown.new(renderer, extensions).render(post.body).html_safe
  end

  def author_gravatar(post)
    hash = Digest::MD5.hexdigest(post.data.author_email)
    "https://www.gravatar.com/avatar/#{hash}"
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
