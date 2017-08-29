module Middleman
  module CoreExtensions
    module Request
      module InstanceMethods
        # See https://github.com/middleman/middleman/commit/b7886aa
        def not_found(res, path)
          path = ::Rack::Utils.escape_html(path)
          res.status = 404
          res.write '<html><head></head><body><h1>File Not Found</h1>' \
                    "<p>#{path}</p></body></html>"
          res.finish
        end
      end
    end
  end
end
