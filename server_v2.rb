require './get_info_file'
require './get_io'
require 'socket'


 server = TCPServer.open 2000

# tracks = Dir['/home/se/Documents/projects/HDT RADIO ONE/tracks/*.mp3']
  # tracks = Dir['/home/se/Documents/projects/HDT RADIO ONE/tracks/Red Hot Chili Peppers - 01 Under The Bridge (Album Version).mp3']

class Player

  @io_client = nil
  @data = []
  
  def initialize new_client, play_data
    @io_client = new_client

    @data = play_data

  end

  def self.write
    @io_client.write @data
  end
 
end

@tracks = get_playlist

@curr_sec = 0

@data_track_seconds = []
@clients = []

# @curr_track = @tracks.shift

# @tracks.each_index do |i|
#   data_track = get_track @tracks[i]
#   @data_track_seconds.push get_data_track_second data_track
# end

Thread.new(@curr_sec) {
    # puts @data_track_seconds[0].size
    # @data_track_seconds.each_index do |i|
    #   @curr_sec = i
    #   # @curr_sec += 1
    #   puts @curr_sec
    #   sleep(0.026)
    # end
    @tracks.each_index do |i|
      @curr_track = @tracks[i]
      data_track = get_track @curr_track 
      
      @data_track_seconds = get_data_track_second data_track
      
      @data_track_seconds.each_index do |s|
        @curr_sec = s
        # puts s
        sleep(1)
        # puts @curr_track
        # puts @curr_sec
        # puts @data_track_seconds.length
      end
      # sleep(@data_track_seconds.length)
      
    end
  }

loop{  
  
  
  client = server.accept
  next_sec = @curr_sec - 1

  Thread.new {
    
    

    # puts @curr_track
    # puts @curr_sec
    # puts @data_track_seconds.length

    frame = ''
    # client.write "HTTP/1.1 200\r\n"
    # client.write "Access-Control-Allow-Origin: *\r\n"
    # client.write "\r\n"
  
    # client.write @data_track_seconds[next_sec-1]

    # for i in (@curr_sec..@data_track_seconds.length) do
    while (next_sec != @data_track_seconds.length-1) do
      frame = @data_track_seconds[next_sec]
      client.write frame
      client.flush
      next_sec += 1
        
      # frame = @data_track_seconds[i]
      
      # client.write frame
      # client.flush
    end
    
  }
  
  
  # @clients.push client
    # method, request_target, _http_version = client.gets.strip.split
    # headers = {}

    # until (line = client.gets) =~ /^\r?\n$/
    #   name, value = line.strip.split(': ')
    #    headers[name] = value
    # end

    # if method.upcase == 'GET'
      # client.write "HTTP/1.1 200\r\n"
      # client.write "Access-Control-Allow-Origin: *\r\n"
      # client.write "\r\n"
    # end

    # client.close

    # @clients.each do |c|
      

    # end

    # client.close

  # curr_track = @tracks.shift

  # puts curr_track
    
  # data_track = get_track curr_track
  # @data_track_seconds = get_data_track_second data_track
  # duration = get_track_duration data_track
  # duration = @data_track_seconds.length


  # while (@data_track_seconds.length != 0) do

  # # data_track_seconds.each do |sec|
  #   # @curr_sec = data_track_seconds.index(sec)
  #   @curr_sec = @data_track_seconds.shift

  #   @clients.each do |c|

  #     c.write @curr_sec
  #     c.flush
  #   end 
  #   sleep(0.026)

  #   # break if n == duration
  # # end
  # end

  # sleep(duration)
  # if @data_track_seconds.length != 0
  #   while (@data_track_seconds.length != 0) do
  #     @curr_sec = @data_track_seconds.shift

  #     @clients.each do |c|

  #       c.write @curr_sec
  #       c.flush
  #     end 
  #     sleep(0.026)
  #   end
  # else
  #   @curr_track = @tracks.shift
  #   @data_track = get_track @curr_track
  #   @data_track_seconds = get_data_track_second @data_track
  # end

  
  
}



 

