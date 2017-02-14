module CustomMappers
  class BlogPostMapper < ContentfulMiddleman::Mapper::Base
    def map(context, entry)
      super
      begin
        context.data = {
          title: entry.title,
          excerpt: entry.excerpt,
          author_name: entry.author.name,
          author_email: entry.author.email,
          author_id: entry.author.slug,
          posted: entry.posted,
          section: 'Blog',
          posts: true
        }
      rescue
        puts 'Check contentful post data. Unable to map.'
      end
    end
  end
end
