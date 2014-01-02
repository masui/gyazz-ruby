require File.expand_path 'test_helper', File.dirname(__FILE__)

class TestGyazz < MiniTest::Test

  def test_version
    assert Gyazz::VERSION >= "0.0.1"
  end

  def test_wiki_methods
    assert Gyazz.wiki('test').class, Gyazz::Wiki
  end

end
