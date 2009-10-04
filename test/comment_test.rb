$:.unshift File.join(File.dirname(__FILE__),'..','lib')
require "test/unit"
require 'rflak'
require 'flexmock/test_unit'

class CommentTest < Test::Unit::TestCase
  def test_create_unauthorized_user
    user = flexmock('user')
    user.should_receive(:authorized?).and_return(false)

    assert_raise(Rflak::NotAuthorized) do
      Rflak::Comment.create(12345, user, 'test content')
    end
  end


  def test_create_new_comment_with_entry_id
    mock_post_request_to_api("200")

    new_comment = Rflak::Comment.create(123456, mock_authorized_user, "My comment body.")
    assert_equal true, new_comment
  end


  def test_create_new_comment_with_entry_object
    mock_post_request_to_api("200")
    entry = Rflak::Entry.new

    new_comment = Rflak::Comment.create(entry, mock_authorized_user, "My comment body.")
    assert_equal true, new_comment
  end


  def test_fail_create_new_comment_with_entry_id
    mock_post_request_to_api("409")

    new_comment = Rflak::Comment.create(123456, mock_authorized_user, "My comment body.")
    assert_equal false, new_comment
  end


  def test_fail_create_new_comment_with_entry_object
    mock_post_request_to_api("409")
    entry = Rflak::Entry.new

    new_comment = Rflak::Comment.create(entry, mock_authorized_user, "My comment body.")
    assert_equal false, new_comment
  end


  protected


  def mock_authorized_user
    user = flexmock('user')
    user.should_receive(:authorized?).and_return(true)
    user.should_receive(:login).and_return('testuser')
    user.should_receive(:api_key).and_return('test_api_key')
    return user
  end


  def mock_post_request_to_api(status)
    response = flexmock('response')
    response.should_receive(:code).once.and_return(status)
    flexmock(Net::HTTP).should_receive(:start).once.and_return(response)
  end
end