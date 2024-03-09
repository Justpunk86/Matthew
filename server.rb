require 'socket'

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

response = []

id3v1 = nil
id3v2 = nil

id3v1_start = 0
id3v1_end = nil

id3v2_start = 0
id3v2_end = 1024

test_frame = nil

# 13-14
# 00 -> none
# 01 -> 3
# 10 - > 2
# 11 -> 1
layer_index = nil

# 16-19
# 0001 -> 32
# 0010 -> 64
# 0011 -> 96
# 0100 -> 128
# ..
bitrate_index = nil

# 20-21
# 00 -> 44000Gzh
# ...
# 
sampling_rate_index = nil

# 24-25 bit
# 00 -> Stereo
# 01 -> Joint Stereo
# 10 -> Dual channel
# 11 -> Mono
channel_mode = nil


  tracks.each do |track|

    f = File.open(track)

    start_id3v1 = f.size - 128

    # test_frame = IO.read(f,1056,1024)  

    id3v1 = IO.read(f,id3v1_end,start_id3v1)
    id3v2 = IO.read(f,id3v2_end,id3v2_start)
    layer_index = IO.read(f,id3v2_end+14,id3v2_end+13)
    bitrate_index = IO.read(f,id3v2_end+19,id3v2_end+16)
    sampling_rate_index = IO.read(f,id3v2_end+21,id3v2_end+20)
    channel_mode = IO.read(f,id3v2_end+25,id3v2_end+24)

      client.puts id3v1
      client.puts id3v2
      client.puts layer_index = 
      client.puts bitrate_index
      client.puts sampling_rate_index
      client.puts channel_mode

    # client.puts test_frame
    
    # bytes = f.read
    # client.write bytes
    h = {
      track_name: File.basename(f, '.mp3'),
      track_size: f.size
      }
    response.push h
    
  end
  # client.puts response
 client.close
}
 

