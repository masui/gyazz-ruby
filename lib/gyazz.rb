# -*- coding: utf-8 -*-
$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'net/http'
require 'json'

class Gyazz
  VERSION = '0.0.8'

  def initialize(name,user=nil,pass=nil,host=nil)
    @name = name
    @user = user
    @pass = pass
    @host = (host ? host : 'gyazz.com')
  end
  
  def http_get(addr)
    ret = nil
    begin
      Net::HTTP.start(@host, 80) {|http|
        req = Net::HTTP::Get.new(addr)
        req.basic_auth @user,@pass if @user
        response = http.request(req)
        raise "status code error (#{response.code})" if response.code != "200"
        ret = response.body
      }
    rescue
    end
    raise "http_get failed" if ret == nil
    ret.chomp
  end

  def list
    # collect がタイムアウトするので
    ret = nil
    begin
      s = http_get("/#{@name}/__list")
      ret = []
      eval(s).each { |e|
        ret << e[0]
      }
    rescue
    end
    raise "List failed" if ret == nil
    return ret
  end
  
  def access(title)
    ret = nil
    begin
      s = http_get("/#{@name}/#{title.gsub(/ /,'%20')}/__access")
      ret = []
      eval(s).each { |e|
        ret << e
      }
    rescue
    end
    raise "Access failed" if ret == nil
    return ret
  end
  
  def modify(title)
    ret = nil
    begin
      s = http_get("/#{@name}/#{title.gsub(/ /,'%20')}/__modify")
      ret = []
      eval(s).each { |e|
        ret << e
      }
    rescue
    end
    raise "Modify failed" if ret == nil
    return ret
  end
  
  def text(title)
    s = nil
    begin
      s = http_get("/#{@name}/#{title.gsub(/ /,'%20')}/text")
    rescue
    end
    raise "text failed" if s == nil
    return s
  end
  
  def settext(title,val)
    if val.class == Array then
      val = val.join("\n")
    end
    data = @name + "\n" + title + "\n" + val
    begin
      Net::HTTP.start(@host, 80) {|http|
        req = Net::HTTP::Post.new('/__write__')
        req.set_form_data('data' => data)
        req.basic_auth @user,@pass if @user
        response = http.request(req)
        raise "status code error (#{response.code})" if response.code != "302"
      }
    rescue
      raise "settext failed"
    end
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

  def related(title)
    ret = []
    begin
      s = http_get("/#{@name}/#{title.gsub(/ /,'%20')}/related")
      if s.match(/^\[/) then
        ret = eval(s)
      end
    rescue
    end
    # raise "Related failed" if ret == nil
    return ret
  end
  
end

