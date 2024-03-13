require './get_info_file'
require './get_io'
require 'socket'

# include TestModule


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

 
  # tracks = Dir['/home/se/Documents/HDT RADIO ONE/tracks/*.mp3']

  # tracks.each do |track|
  #    # f = File.open(track)
  #   # puts track
  #   # download_sleep track
  #   # duration = get_track_duration track
  #   bytes = (get_track track) #f.read

  #   # 
  #   client.write bytes
  #   client.sync = true

  # end

  # data = get_io
  #  data.bytes do |b|
  #   client.write b
  #  end
  
  tracks = Dir['/home/se/Documents/HDT RADIO ONE/tracks/*.mp3']

  tracks.each do |track|
    data = (get_track track)


      client.write data
      client.read
      client.flush

   end

 client.close
}
 

