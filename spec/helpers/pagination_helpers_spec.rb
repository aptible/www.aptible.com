require 'spec_helper'

describe 'pagination helpers' do
  include PaginationHelpers

  describe '#total_pages' do
    it 'returns the total pages with a given page' do
      expect(total_pages(0, 10)).to equal 1
      expect(total_pages(10, 10)).to equal 1
      expect(total_pages(11, 10)).to equal 2
      expect(total_pages(20, 10)).to equal 2
      expect(total_pages(47, 10)).to equal 5
    end
  end

  describe '#prev_link_class' do
    it 'first page returns a class to style an inactive state' do
      expect(prev_link_class(1)).to eq 'blog-posts__page-link--invisible'
    end
    it 'any page but first is an empty result' do
      expect(prev_link_class(2)).to eq ''
    end
  end

  describe '#next_link_class' do
    it 'last page returns a class to style an inactive state' do
      expect(next_link_class(1, 5)).to eq ''
    end
    it 'any page but last is an empty result' do
      expect(next_link_class(5, 5)).to eq 'blog-posts__page-link--invisible'
    end
  end

  describe '#page_links' do
    it 'returns relative paths to each page' do
      root_path = '/blog'
      pages = 1
      links = ['/blog/']
      expect(page_links(pages, root_path)).to eq links

      links << '/blog/page/2/'
      expect(page_links(2, root_path)).to eq links

      links << '/blog/page/3/'
      expect(page_links(3, root_path)).to eq links
    end
  end
end
