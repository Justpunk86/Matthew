require './get_info_file'
require 'socket'

include TestModule


server = TCPServer.open 2000

loop {
  client = server.accept
  # method, request_target, _http_version = client.gets.strip.split
  # headers = {}

  # until (line = client.gets) =~ /^\r?\n$/
  #   name, value = line.strip.split(': ')
  #    headers[name] = value
  # end

  # if method.upcase == 'GET'
    client.write "HTTP/1.1 200\r\n"
    client.write "Access-Control-Allow-Origin: *\r\n"
    client.write "\r\n"
  # end


  tracks = Dir['/home/se/Documents/HDT RADIO ONE/tracks/*.mp3']

  tracks.each do |track|
    f = File.open(track)
    # bytes = f.read
    # client.write bytes
    client.puts mytest()
    client.puts get_frame_info track
  end
  # client.puts response
 client.close
}
 

