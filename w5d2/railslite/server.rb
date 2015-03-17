require 'webrick'
require 'erb'
require 'json'
require 'debugger'

server = WEBrick::HTTPServer(Port: 3000)

trap('INT') { server.shutdown }

server.start
