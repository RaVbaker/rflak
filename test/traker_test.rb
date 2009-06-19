$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'traker'
require 'rubygems'
require 'flexmock/test_unit'

class TrakerTest < Test::Unit::TestCase
  def setup
    @traker = Rflak::Traker.new
  end


  def test_fetch
    flexmock(Rflak::Traker).new_instances.should_receive(:get).and_return(flaker_fake_response)
    response = Rflak::Traker.fetch do |traker|
      traker.url 'netguru.pl'
      traker.limit 2
    end
    assert_kind_of(Array, response)
    response.each do |user|
      assert_kind_of(Rflak::User, user)
    end
  end


  def test_url
    assert_equal Rflak::Traker::FLAK_API_URL + "/url:http://flaker.pl", @traker.url('http://flaker.pl')
  end


  def test_format
    assert_equal Rflak::Traker::FLAK_API_URL + '/format:raw', @traker.format('raw')
  end


  def test_avatars
    assert_equal Rflak::Traker::FLAK_API_URL + '/avatars:medium', @traker.avatars('medium')
  end


  def test_limit
    assert_equal Rflak::Traker::FLAK_API_URL + '/limit:10', @traker.limit(10)
  end


  protected


  def flaker_fake_response
    {
      "site"=>{
        "site_url"=>"http://netguru.pl",
        "site_id"=>"2",
        "site_createdon"=>"1205953764",
        "site_deleted"=>"0",
        "site_user_id"=>"55",
        "site_name"=>"NETGURU" },
      "users"=> [
        { "url" => "http://flaker.pl/zuziak",
          "avatar" => "http://static0.flaker.pl/static/images/flaker/user_generated/u_814_1244208247.jpg_50.jpeg",
          "login"=>"zuziak" }
      ]
    }
  end
end
