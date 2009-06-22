$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'rflak'
require 'rubygems'
require 'flexmock/test_unit'

class UserTest < Test::Unit::TestCase
  def setup
    @user = Rflak::User.new
  end


  def test_respond_to_attribute_getters
    [:action, :url, :sex, :avatar, :login].each do |attribute|
      assert @user.respond_to?(attribute)
    end
  end


  def test_auth_user_with_bad_credentials
    flexmock(Rflak::Flaker).should_receive(:get).with('/type:auth').and_return(auth_bad_credentials)
    resp = Rflak::User.auth('login','bad_auth')
    assert_nil(resp)
  end


  def test_auth_user_with_good_credentials
    flexmock(Rflak::Flaker).should_receive(:get).with('/type:auth').and_return(auth_good_credentials)
    resp = Rflak::User.auth('login', 'good_auth')
    assert_kind_of(Rflak::User, resp)
    assert_equal 'login', resp.login
    assert_equal 'good_auth', resp.api_key
  end


  def test_get_tags_not_authorized
    flexmock(Rflak::Flaker).should_receive(:get).with('/type:auth').and_return(auth_bad_credentials)
    user = Rflak::User.new(:login => 'login', :api_key => 'bad_key')
    assert_equal false, user.auth
    exception = assert_raise(Rflak::NotAuthorized) { user.tags }
    assert_equal 'Not authorized', exception.message
  end


  def test_get_tags_authorized
    tag_list_response = { 'tags' => %w(tag1 tag2 tag3) }
    flexmock(Rflak::Flaker).should_receive(:get).with('/type:auth').once.and_return(auth_good_credentials)
    flexmock(Rflak::Flaker).should_receive(:get).with("/type:tags/login:login").once.and_return(tag_list_response)
    user = Rflak::User.new(:login => 'login', :api_key => 'good_key')
    assert user.auth
    tags = user.tags
    assert_equal tag_list_response['tags'], tags
  end


  def test_get_bookmarks_not_authorized
    flexmock(Rflak::Flaker).should_receive(:get).with('/type:auth').and_return(auth_bad_credentials)
    user = Rflak::User.new(:login => 'login', :api_key => 'bad_key')
    assert_equal false, user.auth
    exception = assert_raise(Rflak::NotAuthorized) { user.bookmarks }
    assert_equal 'Not authorized', exception.message
  end


  def test_get_bookmarks_authorized
    bookmark_list_response = { 'bookmarks' => %w(1 2 3) }
    flexmock(Rflak::Flaker).should_receive(:get).with('/type:auth').once.and_return(auth_good_credentials)
    flexmock(Rflak::Flaker).should_receive(:get).with("/type:bookmarks/login:login").once.and_return(bookmark_list_response)
    flexmock(Rflak::Flaker).should_receive(:fetch).with("show", Proc).times(3).and_return(Rflak::Entry.new)
    user = Rflak::User.new(:login => 'login', :api_key => 'good_key')
    assert user.auth
    bookmarks = user.bookmarks
    assert_equal 3, bookmarks.size
    bookmarks.each do |bookmark|
      assert_kind_of(Rflak::Entry, bookmark)
    end
  end


  protected


  def auth_bad_credentials
    {"status" => {"code" => "401","text" => "Unauthorized","info" => "authorization is required"}}
  end


  def auth_good_credentials
    { "status" => {"code" => "200","text" => "OK","info" =>"authorization successful"}}
  end
end
