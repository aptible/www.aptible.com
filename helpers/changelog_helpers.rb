module ChangelogHelpers
  # TODO: Evaluate contentful model change
  CHANGELOG_TYPES = ['changelog post', 'upcoming feature'].freeze

  def changelog_href(post)
    return post.data.link if post.data.link.present?
    post.url
  end

  def changelog_post?(post)
    CHANGELOG_TYPES.include?(post.data['type'])
  end

  def changelog_group_date(date)
    date.strftime('%B %Y')
  end

  def changelog_posts
    section_pages('Blog')
      .select { |p| changelog_post?(p) }
      .sort_by { |p| -p.data['posted'].to_time.to_i }
  end

  # Changelog posts grouped by year and month
  def changelog_posts_grouped
    changelog_posts.group_by { |post| post.data.posted.strftime('%Y-%m') }
  end
end
