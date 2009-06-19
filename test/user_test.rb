$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'user'

class UserTest < Test::Unit::TestCase
  def setup
    @user = Rflak::User.new
  end


  def test_respond_to_attribute_getters
    [:action, :url, :sex, :avatar, :login].each do |attribute|
      assert @user.respond_to?(attribute)
    end
  end
end
