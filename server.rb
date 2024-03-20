require './get_info_file'
require './get_io'
require 'socket'



# @@stream_data = 

server = TCPServer.open 2000

# tracks = Dir['/home/se/Documents/projects/HDT RADIO ONE/tracks/*.mp3']
  # tracks = Dir['/home/se/Documents/projects/HDT RADIO ONE/tracks/Red Hot Chili Peppers - 01 Under The Bridge (Album Version).mp3']

class Playlist 
  
  @trackss = get_playlist  

  def get_t
    @trackss
  end
end

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

  # @tracks = Playlist.new.get_t

  # while (@tracks.length != 0) do
  # # tracks.each do |track|
     
  #   # download_sleep track

    if(@tracks.length != 0)
    
        
      # data_track =  File.open(@tracks.shift, "r:binary")
      data_track = get_data_track_second get_track @tracks.shift

      n = 0

      # client.write data_track.read(417600)
      # client.flush
          

      data_track.each do |fr|
        # puts fr
        n += 1
        # puts fr.to_s
        client.write fr
        client.flush
        sleep(0.026)

        break if n == 3
      end

      # start = 0
      # offset = 4096
      # # start = start + offset
      # step = 1044
     
      # 1.upto(10199) do |fr|

        

      #   # puts fr
      #    n += 1
        
      #   client.write IO.read(data_track,step,start+offset)
      #    # puts IO.read(out,step,start)

      #   client.flush
      #   start += step
      #   # start = offset + fr * step
      #   sleep(0.026)
      #   # puts "#{n += 1}"
      #    break if n == 10
      # end
        
  
      # duration = get_track_duration data_track
      # client.write "current_time = #{duration-100}"
      # sleep(duration*0.03)
    # end

  else
    @tracks = get_playlist
  end

    client.close
}



 

