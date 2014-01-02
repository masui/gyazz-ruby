module Gyazz

  class Page

    attr_reader :wiki, :name
    def initialize(name, wiki)
      @name = name
      @wiki = wiki
    end

    def url
      "#{@wiki.url}/#{URI.encode @name}"
    end

    def text
      @wiki.get("/#{URI.encode @wiki.name}/#{URI.encode @name}/text")
    end

    def text=(str_or_arr)
      data = str_or_arr.kind_of?(Array) ? str_or_arr.join("\n") : str_or_arr
      @wiki.post("/__write__",
                 :body => {
                   :name => @wiki.name,
                   :title => @name,
                   :data => data
                 })
    end

    def data(opts = {:version => 0})
      JSON.parse @wiki.get("/#{URI.encode @wiki.name}/#{URI.encode @name}/json/#{opts[:version]}")
    end

    def access
      JSON.parse @wiki.get("/#{URI.encode @wiki.name}/#{URI.encode @name}/__access")
    end

    def modify
      JSON.parse @wiki.get("/#{URI.encode @wiki.name}/#{URI.encode @name}/__modify")
    end

    def related_pages
      url = "/#{URI.encode @wiki.name}/#{URI.encode @name}/related"
      JSON.parse(@wiki.get(url)).map{|name|
        Page.new name, @wiki
      }
    end
  end

end
