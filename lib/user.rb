module Rflak
  # Class represents single user of flaker.pl.
  class User
    ATTR_LIST = [:action, :url, :sex, :avatar, :login]

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
  end
end
