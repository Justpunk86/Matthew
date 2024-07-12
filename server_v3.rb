require './get_info_file'
require './get_io'
require 'socket'


 server = TCPServer.open 2000

# class Player

#   @io_client = nil
#   @data = []
  
#   def initialize new_client, play_data
#     @io_client = new_client

#     @data = play_data

#   end

#   def self.write
#     @io_client.write @data
#   end
 
# end

@tracks = get_playlist

@curr_sec = 0

# @data_track_seconds = []
# @clients = []

# @curr_pos_play = []

Thread.new {
    # puts @data_track_seconds[0].size
    # @data_track_seconds.each_index do |i|
    #   @curr_sec = i
    #   # @curr_sec += 1
    #   puts @curr_sec
    #   sleep(0.026)
    # end
    @tracks.each_index do |i|
      @curr_sec = i
      # puts @tracks[i]
      # @curr_pos_play.push get_track @tracks[i]
      sleep(1)
      # @curr_track = @tracks[i]
      # data_track = get_track @curr_track 
      
      # @data_track_seconds = get_data_track_second data_track
      # seconds = get_frames data_track
      
      # 0.upto(seconds.length) do |s|
      #   @curr_sec = s
      #   puts s
      #   sleep(1)
      # end



      # loop {
      #   @curr_sec += 38
      #   sleep(1)

      #   break if @curr_sec == seconds.length
      # }

    end
  }

loop{  
  
  client = server.accept

  # @tracks.each do |t|

  #   data_track = get_track t

  #   frames = get_frames data_track

  #   frames.each_index do |f|
  #     # puts f.chop
  #     if f == 0
  #      client.write frames[f].chop
  #      client.flush
  #     elsif f >= @curr_sec
  #      client.write frames[f].chop
  #      client.flush
  #    end
  #   end
  # end
  
   # now_sec = @curr_sec
  # data_track = get_track @curr_track

  Thread.new(client, @curr_sec) do |c, cs|
    puts cs
    c.write "HTTP/1.1 200\r\n"
    c.write "Access-Control-Allow-Origin: *\r\n"
    c.write "\r\n"

    c_playlist = []
    tr_data = ''

    cs.upto(@tracks.length-1) do |i|

      tr_data += get_track @tracks[i]
      
    end

    c_playlist.push tr_data

    c_playlist.each do |data|
      c.write data
      c.flush
    end

    # data_track = get_track @curr_track

    # frames = get_frames data_track

    # seconds = get_data_track_second data_track

    # frames.each_index do |f|
    #   # puts f.chop
    #   if f == 0 
    #    client.write frames[f].chop
    #    # client.flush
    #   end
    #   if f >= @curr_sec
    #    client.write frames[f].chop
    #    client.flush
    #   end
    # end
  
  end
  
  
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

}



 

