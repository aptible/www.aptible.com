module SocialHelpers
  def facebook_share_href(url)
    "https://www.facebook.com/sharer/sharer.php?u=#{URI.escape(url)}"
  end

  def twitter_share_href(url, text)
    url = URI.escape(url)
    text = URI.escape("#{text} @aptible")

    "https://twitter.com/intent/tweet?original_referer=#{url}" \
      "&ref_src=twsrc%5Etfw&text=#{text}&tw_p=tweetbutton&url=#{url}"
  end

  def linkedin_share_href(url, title, excerpt)
    'https://www.linkedin.com/shareArticle?mini=true' \
      "&url=#{URI.escape(url)}&title=#{URI.escape(title)}" \
      "&summary=#{URI.escape(excerpt)}"
  end

  def hackernews_share_href(url, title)
    "http://news.ycombinator.com/submitlink?u=#{URI.escape(url)}" \
    "&t=#{URI.escape(title)}"
  end

  def mailto_share_href(url, subject, excerpt)
    body = <<-BODY
#{excerpt}

#{url}
BODY
    "mailto:?subject=#{URI.escape(subject)}&body=#{URI.escape(body)}"
  end
end
