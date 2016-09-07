module NavHelpers
  def quickstart?(url)
    url.include? 'support/quickstart'
  end

  def support_topic?(url)
    url.include? 'support/topics'
  end
end
