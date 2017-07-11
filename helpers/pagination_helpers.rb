module PaginationHelpers
  def total_pages(set_size, per_page)
    return 1 if set_size <= per_page
    total = set_size / per_page
    total += 1 unless set_size % per_page == 0
    total
  end

  def paginated_subsets(set, per_page)
    start = 0
    finish = per_page
    subsets = []
    total_pages(set.count, per_page).times do
      subsets << set[start...finish]
      start += per_page
      finish += per_page
    end
    subsets
  end

  def prev_link_class(current_page)
    current_page == 1 ? 'blog-posts__page-link--invisible' : ''
  end

  def next_link_class(current_page, last_page)
    current_page == last_page ? 'blog-posts__page-link--invisible' : ''
  end

  def page_links(pages, root_path)
    links = ["#{root_path}/"]
    return links if pages < 2

    (2..pages).each { |page_num| links << "#{root_path}/page/#{page_num}/" }
    links
  end
end
