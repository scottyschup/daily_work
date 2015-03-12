def super_print(string, opts={})
  options = {
    times: 1,
    upcase: false,
    reverse: false
  }.merge(opts)

  string.upcase! if options[:upcase]
  string.reverse! if options[:reverse]
  puts string * options[:times]
end
