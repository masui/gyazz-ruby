module Gyazz

  class Page

    attr_reader :wiki, :name
    alias_method :title, :name

    def initialize(name, wiki)
      @name = name
      @wiki = wiki
    end

    def url
      "#{@wiki.url}/#{URI.encode @name}"
    end

    def text(opts={})
      @wiki.get("/#{URI.encode @wiki.name}/#{URI.encode @name}/text", opts)
    end

    def text=(str_or_arr, opts={})
      data = str_or_arr.kind_of?(Array) ? str_or_arr.join("\n") : str_or_arr
      unless opts.has_key? :body
        opts[:body] = {
          :name => @wiki.name,
          :title => @name,
          :data => data
        }
      end
      @wiki.post("/__write__", opts)
    end

    def data(opts={:query => {:version => 0}})
      JSON.parse @wiki.get("/#{URI.encode @wiki.name}/#{URI.encode @name}/json", opts)
    end

    def access(opts={})
      JSON.parse @wiki.get("/#{URI.encode @wiki.name}/#{URI.encode @name}/__access", opts)
    end

    def modify(opts={})
      JSON.parse @wiki.get("/#{URI.encode @wiki.name}/#{URI.encode @name}/__modify", opts)
    end

    def related_pages(opts={})
      url = "/#{URI.encode @wiki.name}/#{URI.encode @name}/related"
      JSON.parse(@wiki.get(url, opts)).map{|name|
        Page.new name, @wiki
      }
    end
  end

end
