require File.expand_path 'test_helper', File.dirname(__FILE__)

class TestWiki < MiniTest::Test

  def setup
    @wiki = Gyazz::Wiki.new 'test'
    @wiki.host = ENV['GYAZZ_HOST'] if ENV.has_key? 'GYAZZ_HOST'
  end

  def test_url
    host = ENV['GYAZZ_HOST'] || 'http://gyazz.com'
    assert_equal @wiki.url , "#{host}/#{@wiki.name}"
  end

  def test_pages
    pages = @wiki.pages
    assert_equal pages.class, Array
    pages.each do |page|
      assert_equal page.class, Gyazz::Page
    end
  end

  def test_pages_with_options
    pages = @wiki.pages :timeout => 120
    assert_equal pages.class, Array
    pages.each do |page|
      assert_equal page.class, Gyazz::Page
    end
  end

end
