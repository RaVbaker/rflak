$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'connection'
require 'rubygems'
require 'fakeweb'

class ConnectionTest < Test::Unit::TestCase
  def setup
    @flak_connection = Rflak::Connection.new
  end


  def test_fetch
    FakeWeb.register_uri(:get,"http://api.flaker.pl/api/type:user/login:dstranz/limit:2", :string => fake_response_from_flaker)
    response = Rflak::Connection.go('user') do |conn|
      conn.login 'dstranz'
      conn.limit 2
    end
    assert_kind_of(Array, response)
    response.each do |entry|
      assert_kind_of(Rflak::Entry, entry)
      assert_kind_of(Rflak::User, entry.user)
    end
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


  protected


  def fake_response_from_flaker
    <<END
{"user":{"login":"dstranz","avatar":"http:\/\/static0.flaker.pl\/static\/images\/flaker\/user_generated\/u_139_1227549010.jpg_50.jpeg","url":"http:\/\/flaker.pl\/dstranz","sex":"m"},"entries":[{"id":"854874","title":"<!--deprecated-->","text":"<div class=\"etext\">Poczt\u00f3wka z #<a class=\"tag\" title=\"zobacz inne wpisy otagowane jako Bydgoszcz\" href=\"http:\/\/flaker.pl\/t\/bydgoszcz\">Bydgoszcz<\/a>.y. Ulica Focha, plac Teatralny, w tle Opera. <span class=\"original-link type_flaker\"><a href=\"\" title=\"\" class=\"link\" rel=\"nofollow\"><\/a> <\/span><\/div>","source":"flaker","data":{"images":[{"big":"m_139_1227962103_0_600.jpeg","small":"m_139_1227962103_0_75.jpeg","alt":""}]},”time”:”Sat, 29 Nov 2008 12:35:05 +0100″,”datetime”:”2008-11-29 12:35:05″,”timestamp”:”1227958505″,”permalink”:”http:\/\/flaker.pl\/f\/854874″,”link”:”",”has_photo”:”1″,”has_link”:”0″,”has_video”:”0″,”user”:{”login”:”dstranz”,”avatar”:”http:\/\/static0.flaker.pl\/static\/images\/flaker\/user_generated\/u_139_1227549010.jpg_50.jpeg”,”url”:”http:\/\/flaker.pl\/dstranz”,”sex”:”m”,”action”:”wrzuci\u0142 obrazek na Flakera”},”comments”:[]}]}
END
  end
end
