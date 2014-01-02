require File.expand_path 'test_helper', File.dirname(__FILE__)

class TestWikiAuth < MiniTest::Test

  def setup
    @wiki = Gyazz::Wiki.new 'test_auth'
    @wiki.host = ENV['GYAZZ_HOST'] if ENV.has_key? 'GYAZZ_HOST'
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
    @wiki.auth = {:username => 'test_username', :password => 'test_password'}
    pages = @wiki.pages
    assert_equal pages.class, Array
    pages.each do |page|
      assert_equal page.class, Gyazz::Page
    end
  end

end
