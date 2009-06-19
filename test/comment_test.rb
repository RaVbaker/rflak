$:.unshift File.join(File.dirname(__FILE__),'..','lib')
require "test/unit"
require 'comment'

class CommentTest < Test::Unit::TestCase
  def test_true
    assert true
  end
end