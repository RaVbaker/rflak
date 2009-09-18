module Rflak
  # Class represents single comment assigned to 'flak'
  class Comment < DummyEntry
    ATTR_LIST = [:user, :permalink, :timestamp, :time, :text, :datetime, :source, :data, :subsource,
      :url, :related_id
    ]

    # define attribute methods public getters and private setters
    ATTR_LIST.each do |attr|
      attr_reader attr

      # user= method from dummy entry
      unless attr == :user
        attr_writer(attr)
        protected attr.to_s + '='
      end
    end


    def initialize(options = {})
      options.each_pair do |key, value|
        send("#{ key }=", value)
      end
    end
  end
end
