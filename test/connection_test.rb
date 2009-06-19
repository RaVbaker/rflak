$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'connection'

class ConnectionTest < Test::Unit::TestCase
  def setup
    @flak_connection = Rflak::Connection.new
  end


  def test_login
    assert_equal '/login:seban', @flak_connection.login('seban')
  end


  def test_url
    assert_equal '/url:http://google.pl', @flak_connection.url('http://google.pl')
  end


  def test_entry_id
    assert_equal '/entry_id:1', @flak_connection.entry_id(1)
  end


  def test_source
    assert_equal '/source:photos', @flak_connection.source('photos')
  end


  def test_tag
    assert_equal '/tag:ruby', @flak_connection.tag('ruby')
  end


  def test_mode
    assert_equal '/mode:raw', @flak_connection.mode('raw')
  end


  def test_avatars
    assert_equal '/avatars:small', @flak_connection.avatars('small')
  end


  def test_limit
    assert_equal '/limit:50', @flak_connection.limit('50')
  end


  def test_from
    assert_equal '/from:100', @flak_connection.from('100')
  end


  def test_start
    assert_equal '/start:12345', @flak_connection.start('12345')
  end


  def test_since
    time = Time.now.to_i
    assert_equal "/start:#{ time }", @flak_connection.start(time)
  end


  def test_sort
    assert_equal '/sort:desc', @flak_connection.sort('desc')
  end


  def test_comments
    assert_equal '/comments:false', @flak_connection.comments(false)
  end
end
