$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'rflak'
require 'flexmock/test_unit'

class EntryTest < Test::Unit::TestCase
  def setup
    @hash = {
      "user"=>{"action"=>"wrzuci\305\202 link na Flakera", "url"=>"http://flaker.pl/prawnik10",
        "sex"=>"m", "avatar"=>"http://static0.flaker.pl/static/images/flaker/default_avatar_50.jpg",
        "login"=>"prawnik10" },
      "permalink"=>"http://flaker.pl/f/1899329",
      "timestamp"=>"1245317709",
      "comments"=>[],
      "time"=>"Thu, 18 Jun 2009 11:35:09 +0200",
      "text"=>"Jakiś fajny tekst wrzucony na flakerka. Przepraszam oryginalnego autora - prawnik10 za zmianę ;)",
      "source"=>"flaker",
      "data"=>[]
    }

    @entry = Rflak::Entry.new(@hash)
  end


  def test_respond_to_attribute_getters
    [:user, :permalink, :timestamp, :comments, :time, :text, :title, :has_video, :id,
      :has_photo, :link, :has_link, :datetime, :source, :data
    ].each do |attribute|
      assert @entry.respond_to?(attribute)
    end
  end


  def test_new_object
    assert_kind_of(Rflak::User, @entry.user)
  end


  def test_create_new_entry_unauthorized_user
    user = flexmock('user')
    user.should_receive(:authorized?).and_return(false)

    assert_raise(Rflak::NotAuthorized) do
      Rflak::Entry.create(user, 'text' => 'test content')
    end
  end


  def test_create_new_entry_authorized_user
    user = flexmock('user')
    user.should_receive(:authorized?).and_return(true)
    user.should_receive(:login).and_return('testuser')
    user.should_receive(:api_key).and_return('test_api_key')
    response_body =  "\r\n\r\n{\"status\":{\"code\":\"200\",\"text\":\"OK\",\"info\":\"http:\\/\\/flaker.pl\\/f\\/2077989\"}}"
    response = flexmock('response')
    response.should_receive(:body).and_return(response_body)
    flexmock(Net::HTTP).should_receive(:start).and_return(response)
    flexmock(Rflak::Flaker).should_receive(:fetch).and_return([Rflak::Entry.new])

    response = Rflak::Entry.create(user, 'text' => 'test content')
    assert_kind_of(Rflak::Entry, response)
  end


  def test_bookmark_authorized_user
    flexmock(Rflak::Flaker).should_receive(:get).with('/type:auth').and_return(auth_bad_credentials)
    user = Rflak::User.new(:login => 'login', :api_key => 'bad_key')

    assert_equal false, user.auth
    assert_raise(Rflak::NotAuthorized) { @entry.bookmark(user) }
  end


  def test_bookmark_authorized_user
    bookmark_response =  {"status"=>{"text"=>"OK", "code"=>"200", "info"=>"bookmark created"}}
    bookmark_list_response = { 'bookmarks' => %w(1 2 3) }
    flexmock(Rflak::Flaker).should_receive(:get).with('/type:auth').once.and_return(auth_good_credentials)
    flexmock(Rflak::Flaker).should_receive(:get).with("/type:bookmark/action:set/entry_id:#{ @entry.id }").times(1).and_return(bookmark_response)
    flexmock(Rflak::Flaker).should_receive(:get).with('/type:list/source:bookmarks/login:login').times(1).and_return(bookmark_list_response)
    flexmock(Rflak::Flaker).should_receive(:fetch).with("show", Proc).times(3).and_return(Rflak::Entry.new)

    user = Rflak::User.new(:login => 'login', :api_key => 'good_key')

    resp = @entry.bookmark(user)
    assert_kind_of(Array, resp)
    resp.each { |r| assert_kind_of(Rflak::Entry, r) }
  end


  def test_unbookmark_not_authorized_user
    flexmock(Rflak::Flaker).should_receive(:get).with('/type:auth').and_return(auth_bad_credentials)
    user = Rflak::User.new(:login => 'login', :api_key => 'bad_key')

    assert_equal false, user.auth
    assert_raise(Rflak::NotAuthorized) { @entry.unbookmark(user) }
  end


  def test_unbookmark_authorized_user
    bookmark_response =  {"status"=>{"text"=>"OK", "code"=>"200", "info"=>"i dont't know"}}
    bookmark_list_response = { 'bookmarks' => %w(1 2 3) }
    flexmock(Rflak::Flaker).should_receive(:get).with('/type:auth').once.and_return(auth_good_credentials)
    flexmock(Rflak::Flaker).should_receive(:get).with("/type:bookmark/action:unset/entry_id:#{ @entry.id }").times(1).and_return(bookmark_response)
    flexmock(Rflak::Flaker).should_receive(:get).with('/type:list/source:bookmarks/login:login').times(1).and_return(bookmark_list_response)
    flexmock(Rflak::Flaker).should_receive(:fetch).with("show", Proc).times(3).and_return(Rflak::Entry.new)

    user = Rflak::User.new(:login => 'login', :api_key => 'good_key')

    resp = @entry.unbookmark(user)
    assert_kind_of(Array, resp)
    resp.each { |r| assert_kind_of(Rflak::Entry, r) }
  end


  protected


  def auth_bad_credentials
    {"status" => {"code" => "401","text" => "Unauthorized","info" => "authorization is required"}}
  end


  def auth_good_credentials
    { "status" => {"code" => "200","text" => "OK","info" =>"authorization successful"}}
  end
end
