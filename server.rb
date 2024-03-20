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

@tracks = get_playlist

@curr_sec = 0

@data_track_seconds = []

# Socket.tcp_server_loop("localhost", 2000) {
loop{  
  # Thread.new {
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
  

    while (@tracks.length != 0) do
       
      # if(@tracks.length != 0)


      curr_track = @tracks.shift

      puts curr_track
        
      # data_track =  File.open(@tracks.shift, "r:binary")
      data_track = get_track curr_track
      @data_track_seconds = get_data_track_second data_track
      duration = get_track_duration data_track

      puts duration

      while (@data_track_seconds.length != 0) do

      # data_track_seconds.each do |sec|
        # @curr_sec = data_track_seconds.index(sec)
        @curr_sec = @data_track_seconds.shift
        client.write @curr_sec
        client.flush
        # sleep(0.026)

        # break if n == duration
      # end
      end

      sleep(duration)

      # else
      #   @tracks = get_playlist
      # end
      # end while
    end

    client.close
  # }
}



 

