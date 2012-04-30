require File.dirname(__FILE__) + '/test_helper.rb'

class TestGyazz < Test::Unit::TestCase
  def test_text
    g = Gyazz.new('test')
    g.set('test','bbbbb')
    assert_equal(g.get('test'),"bbbbb")
    
    val = ["abc", "def"]
    g.settext('test',val)
    assert_equal(g.text('test'),"abc\ndef")
    
    val = ["abc\ndef"]
    g.settext('test',val)
    assert_equal(g.text('test'),"abc\ndef")
    
    list = g.list
    assert_equal(list.class,Array)
    assert(list.length > 0)
  end
  
  def test_auth
    #
    # http://Gyazz.com/test_auth/
    #  user: test_username
    #  pass: test_password
    #
    g = Gyazz.new('test_auth','test_username','test_password')
    g.set('test','abcdefg')
    assert_equal(g.get('test'),'abcdefg')
    g.set('test','99999')
    assert_equal(g.get('test'),'99999')
  end
end
