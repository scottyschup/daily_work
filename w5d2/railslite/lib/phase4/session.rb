require 'json'
require 'webrick'
require 'byebug'

module Phase4
  class Session
    COOKIE_NAME = '_rails_lite_app'
    # find the cookie for this app
    # deserialize the cookie into a hash
    def initialize(req)
      @cookie = req.cookies.find do |cookie|
        cookie.name == COOKIE_NAME
      end

      if @cookie
        @data = JSON.parse(@cookie.value)
      else
        @data = {}
        @cookie = WEBrick::Cookie.new(COOKIE_NAME, @data.to_json)
      end
    end

    def [](key)
      @data[key]
    end

    def []=(key, val)
      @data[key] = val
    end

    # serialize the hash into json and save in a cookie
    # add to the responses cookies
    def store_session(res)
      @cookie.value = @data.to_json
      res.cookies << @cookie
    end
  end
end
