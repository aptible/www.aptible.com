module PaginationHelpers
  PAGE_SIZE = 10
  def total_pages(set_size)
    return 1 if set_size <= PAGE_SIZE
    total = set_size / PAGE_SIZE
    total = total + 1 unless set_size % PAGE_SIZE == 0
    total
  end

  def paginated_subsets(set)
    start = 0
    finish = PAGE_SIZE
    subsets = []
    total_pages(set.count).times do
      subsets << set[start...finish]
      start += PAGE_SIZE
      finish += PAGE_SIZE
    end
    subsets
  end

  def prev_link_class(current_page)
    current_page == 1 ? 'blog-posts__page-link--invisible' : ''
  end

  def next_link_class(current_page, size)
    current_page == size ? 'blog-posts__page-link--invisible' : ''
  end

  def page_links(set, root_path)
    links = Array.new
    set.each_with_index do |p, index|
      if index == 0
        links << root_path
      else
        links << "#{root_path}page/#{index + 1}/"
      end
    end
    links
  end
end
