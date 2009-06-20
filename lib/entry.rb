module Rflak
  # Class represents single entry in flaker.pl website. Entry is assigned with user to wich it belongs
  # and can have many comments assigned to it.
  class Entry
    ATTR_LIST = [:user, :permalink, :timestamp, :comments, :time, :text, :title, :has_video, :id,
      :has_photo, :link, :has_link, :datetime, :source, :data
    ]

    # define attribute methods public getters and private setters
    ATTR_LIST.each do |attr|
      attr_reader attr
      attr_writer(attr)
      private attr.to_s + '='
    end

    def initialize(options = {})
      options.each_pair do |key, value|
        send("#{ key }=", value)
      end
    end


    private


    # Set the user based on passed values
    #
    # options:: Hash, default empty Hash
    def user=(options = {})
      @user = User.new(options)
    end


    # Set the comments collection based on passed value
    #
    # options:: Array of Hashes, default []
    def comments=(collection = [])
      return collection if collection.empty?
      @comments = collection.map { |comment_hash| Comment.new(comment_hash) }
    end
  end
end
