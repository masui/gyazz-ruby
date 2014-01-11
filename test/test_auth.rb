require File.expand_path 'test_helper', File.dirname(__FILE__)

class TestWikiAuth < MiniTest::Test

  def setup
    @wiki = Gyazz::Wiki.new 'test_auth'
    @wiki.host = ENV['GYAZZ_HOST'] if ENV.has_key? 'GYAZZ_HOST'
    @auth = {:username => 'test_username', :password => 'test_password'}
  end

  def test_auth_fail
    err = nil
    begin
      @wiki.pages
    rescue => e
      err = e
    end
    assert_equal err.class, Gyazz::Error
  end

  def test_auth
    @wiki.auth = @auth
    pages = @wiki.pages
    assert_equal pages.class, Array
    pages.each do |page|
      assert_equal page.class, Gyazz::Page
    end
  end

  def test_auth_page_get_fail
    page = @wiki.page('aaa')
    err = nil
    begin
      page.text
    rescue => e
      err = e
    end
    assert_equal err.class, Gyazz::Error
  end

  def test_manually_auth
    pages = @wiki.pages(:basic_auth => @auth)
    assert_equal pages.class, Array
    pages.each do |page|
      assert_equal page.class, Gyazz::Page
    end
  end

  def test_auth_page_get_set
    @wiki.auth = @auth
    page = @wiki.page("aaa_ruby#{RUBY_VERSION}")
    body = ["foo", "bar", Time.now.to_s].join("\n")
    page.text = body
    assert_equal page.text.strip, body
  end

end
