shared_examples 'a table of contents' do |toc, path|
  toc.each do |section_name, section|
    describe section_name do
      section['articles'].each do |article|
        describe article['title'] do
          unless article['draft']
            it_behaves_like 'a valid page', article, section, path
          end
        end
      end if section['articles']
    end
  end
end
