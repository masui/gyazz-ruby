require File.expand_path 'test_helper', File.dirname(__FILE__)

class TestPage < MiniTest::Test

  def setup
    @wiki = Gyazz::Wiki.new('test')
    @wiki.host = ENV['GYAZZ_HOST'] if ENV.has_key? 'GYAZZ_HOST'
    @page = @wiki.page("aaa_ruby#{RUBY_VERSION}")
  end

  def test_title_name
    assert_equal @page.title, @page.name
  end

  def test_url
    host = ENV['GYAZZ_HOST'] || 'http://gyazz.com'
    assert_equal @page.url , "#{host}/#{@wiki.name}/#{@page.name}"
  end

  def test_get_text
    assert_equal @page.text.class, String
  end

  def test_set_text
    body = ["foo", "bar", Time.now.to_s].join("\n")
    @page.text = body
    assert_equal @page.text.strip, body
  end

  def test_data
    assert_equal @page.data.class, Hash
  end

  def test_access
    assert_equal @page.access.class, Array
  end

  def test_access
    assert_equal @page.modify.class, Array
  end

  def test_related_pages
    pages = @page.related_pages
    assert_equal pages.class, Array
    pages.each do |page|
      assert_equal page.class, Gyazz::Page
    end
  end

end
