module Gyazz

  class Wiki

    attr_reader :name, :host

    def initialize(name)
      @name = name
      @host = 'http://gyazz.com'
    end

    def url
      "#{@host}/#{URI.encode @name}"
    end

    def host=(host)
      @host = host
    end

    def auth=(opts)
      @basic_auth = opts
    end

    def page(name)
      Page.new name, self
    end

    def get(path)
      res = HTTParty.get "#{@host}#{path}", :basic_auth => @basic_auth
      case res.code
      when 200
        return res.body
      else
        raise Gyazz::Error, res.body
      end
    end

    def post(path, opts)
      opts[:basic_auth] = @basic_auth if @basic_auth
      res = HTTParty.post "#{@host}#{path}", opts
      case res.code
      when 200
        return res.body
      else
        raise Gyazz::Error, res.body
      end
    end

    def pages
      JSON.parse(self.get "/#{@name}/__list").map{|i|
        Page.new(i[0], self)
      }
    end
  end

end
