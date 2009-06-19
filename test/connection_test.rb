$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'connection'
require 'rubygems'
require 'flexmock/test_unit'

class ConnectionTest < Test::Unit::TestCase
  def setup
    @flak_connection = Rflak::Connection.new('user')
  end


  def test_fetch
    flexmock(Rflak::Connection).new_instances.should_receive(:get).and_return(flaker_fake_response)
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
    assert_equal @flak_connection.perform_url + '/login:seban', @flak_connection.login('seban')
  end


  def test_url
    assert_equal @flak_connection.perform_url + '/url:http://google.pl', @flak_connection.url('http://google.pl')
  end


  def test_entry_id
    assert_equal @flak_connection.perform_url + '/entry_id:1', @flak_connection.entry_id(1)
  end


  def test_source
    assert_equal @flak_connection.perform_url + '/source:photos', @flak_connection.source('photos')
  end


  def test_tag
    assert_equal @flak_connection.perform_url + '/tag:ruby', @flak_connection.tag('ruby')
  end


  def test_mode
    assert_equal @flak_connection.perform_url + '/mode:raw', @flak_connection.mode('raw')
  end


  def test_avatars
    assert_equal @flak_connection.perform_url + '/avatars:small', @flak_connection.avatars('small')
  end


  def test_limit
    assert_equal @flak_connection.perform_url + '/limit:50', @flak_connection.limit('50')
  end


  def test_from
    assert_equal @flak_connection.perform_url + '/from:100', @flak_connection.from('100')
  end


  def test_start
    assert_equal @flak_connection.perform_url + '/start:12345', @flak_connection.start('12345')
  end


  def test_since
    time = Time.now.to_i
    assert_equal @flak_connection.perform_url + "/start:#{ time }", @flak_connection.start(time)
  end


  def test_sort
    assert_equal @flak_connection.perform_url + '/sort:desc', @flak_connection.sort('desc')
  end


  def test_comments
    assert_equal @flak_connection.perform_url + '/comments:false', @flak_connection.comments(false)
  end


  protected


  def flaker_fake_response
    # hard
    { "user"=>{
        "url" => "http://flaker.pl/dstranz",
        "sex"=>"m",
        "avatar"=>"http://static0.flaker.pl/static/images/flaker/user_generated/u_139_1227549010.jpg_50.jpeg",
        "login"=>"dstranz"},
      "entries"=>[
        {"user" => {
          "action" => "wrzuci\305\202 link na Flakera",
          "url" => "http://flaker.pl/dstranz",
          "sex"=> "m",
          "avatar" => "http://static0.flaker.pl/static/images/flaker/user_generated/u_139_1227549010.jpg_50.jpeg",
          "login"=>"dstranz" },
        "permalink" => "http://flaker.pl/f/1909570",
        "timestamp" => "1245366699",
        "comments" => [],
        "time"=> "Fri, 19 Jun 2009 01:11:39 +0200",
        "text" => "tekst tekst tekst",
        "title"=>"<!--deprecated-->",
        "has_video"=>"0",
        "id"=>"1909570",
        "has_photo"=>"1",
        "link"=>"",
        "has_link"=>"1",
        "datetime"=>"2009-06-19 01:11:39",
        "source"=>"flaker",
        "data" => {
          "images"=>[
            { "small"=>"f_139_1245369384_0_75.jpeg",
              "big"=>"f_139_1245369384_0_495.jpeg",
              "medium"=>"f_139_1245369384_0_285.jpeg",
              "alt"=>"alt alt"
            }]}
        }
      ]
    }
  end
end
