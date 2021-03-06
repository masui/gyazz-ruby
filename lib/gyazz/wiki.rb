module Gyazz

  class Wiki

    attr_reader :name, :host

    def initialize(name)
      @name = name
      @host = 'http://gyazz.com'
    end

    def url
      "#{@host}/#{ERB::Util.url_encode @name}"
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

    def get(path, opts={})
      opts[:basic_auth] = @basic_auth if @basic_auth and !opts.has_key?(:basic_auth)
      res = HTTParty.get "#{@host}#{path}", opts
      case res.code
      when 200
        return res.body
      else
        raise Gyazz::Error, res.body
      end
    end

    def post(path, opts={})
      opts[:basic_auth] = @basic_auth if @basic_auth and !opts.has_key?(:basic_auth)
      res = HTTParty.post "#{@host}#{path}", opts
      case res.code
      when 200
        return res.body
      else
        raise Gyazz::Error, res.body
      end
    end

    def pages(opts={})
      JSON.parse(self.get "/#{ERB::Util.url_encode @name}/__list", opts).map{|i|
        Page.new(i[0], self)
      }
    end
  end

end
