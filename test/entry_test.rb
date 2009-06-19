$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'entry'
require 'user'

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
end
