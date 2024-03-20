require './get_info_file'
require './get_io'
require 'socket'

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

@curr_data = ''
@curr_sec = 0

@data_track_seconds = []

loop{ 

  client = server.accept

  while (@tracks.length != 0) do
       
    curr_track = @tracks.shift

    puts curr_track
      
    data_track = get_track curr_track
    @data_track_seconds = get_data_track_second data_track
    duration = get_track_duration data_track

    puts duration

    while (@data_track_seconds.length != 0) do

      @curr_data = @data_track_seconds.shift
      @curr_sec = @data_track_seconds.index(@curr_data)
      
      # sleep(0.026)
    end

    sleep(duration)

  end

  Thread.new {
     
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

    while (@data_track_seconds.length != 0) do
      client.write @curr_data
      client.flush
    end
     client.close
  }

}



 

