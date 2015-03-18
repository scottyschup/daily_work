require 'uri'
require 'byebug'

module Phase5
  class Params
    # use your initialize to merge params from
    # 1. query string
    # 2. post body
    # 3. route params
    #
    # You haven't done routing yet; but assume route params will be
    # passed in as a hash to `Params.new` as below:
    def initialize(req, route_params = {})
      @params = route_params
      @params.merge!(parse_www_encoded_form(req.query_string))
      @params.merge!(parse_www_encoded_form(req.body))
    end

    def [](key)
      @params[key.to_s]
    end

    def to_s
      @params.to_json.to_s
    end

    class AttributeNotFoundError < ArgumentError; end;

    private
    # this should return deeply nested hash
    # argument format
    # user[address][street]=main&user[address][zip]=89436
    # should return
    # { "user" => { "address" => { "street" => "main", "zip" => "89436" } } }
    def parse_www_encoded_form(www_encoded_form)
      return {} unless www_encoded_form

      decoded_params = URI::decode_www_form(www_encoded_form)

      key_value_pairs = decoded_params.map do |elem|
        parse_key(elem)
      end

      result = {}

      key_value_pairs.each do |key_arr, val|
        current_node = result

        key_arr.each_with_index do |key, i|
          if i == key_arr.length - 1
            current_node[key] = val
          else
            current_node[key] = {} unless current_node[key].is_a?(Hash)
            current_node = current_node[key]
          end
        end
      end

      result
    end

    # this should return an array
    # user[address][street] should return ['user', 'address', 'street']
    def parse_key(elem)
      unless elem[0].is_a?(Array)
        [elem[0].split(/\]\[|\[|\]/), elem[1]]
      else
        elem.split(/\]\[|\[|\]/)
      end
    end
  end
end
