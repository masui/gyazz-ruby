$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'net/http'

class Gyazz
  VERSION = '0.0.2'

  def initialize(name,user=nil,pass=nil)
    @name = name
    @user = user
    @pass = pass
  end
  
  def http_get(addr)
    ret = ''
    begin
      Net::HTTP.start('gyazz.com', 80) {|http|
        req = Net::HTTP::Get.new(addr)
        req.basic_auth @user,@pass if @user
        response = http.request(req)
        ret = response.body
      }
    rescue
    end
    ret.chomp
  end
  
  def list
    ret = nil
    begin
      s = http_get("/#{@name}/__list")
      ret = eval(s).collect { |e|
        e[0]
      }
    rescue
    end
    return ret
  end
  
  def text(title)
    s = nil
    begin
      s = http_get("/#{@name}/#{title.gsub(/ /,'%20')}/text")
    rescue
    end
    return s
  end
  
  def settext(title,val)
    if val.class == Array then
      val = val.join("\n")
    end
    data = @name + "\n" + title + "\n" + val
    Net::HTTP.start('gyazz.com', 80) {|http|
      req = Net::HTTP::Post.new('/__write__')
      req.set_form_data('data' => data)
      req.basic_auth @user,@pass if @user
      response = http.request(req)
    }
  end
  
  def get(title)
    text(title)
  end
  
  def set(title,val)
    settext(title,val)
  end
  
  def each
    list.each { |title|
      yield title
    }
  end
end

