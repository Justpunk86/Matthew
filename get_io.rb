require './get_info_file'

  @tracks = Dir['/home/se/Documents/projects/HDT RADIO ONE/tracks/*.mp3']
#@tracks = Dir['/home/se/Documents/projects/HDT RADIO ONE/tracks/Red Hot Chili Peppers - 01 Under The Bridge (Album Version).mp3']


 @in_io = IO.new(1, "w+")
# out_io = IO.new(in_io, "r")

# @in_io, @out_io = IO.pipe

# @in_io = STDIN
# @out_io = STDOUT


# def get_io
  
#   @tracks.each do |track|
#      data = IO.read(track)

#      @out_io.write data
#     # data.bytes do |b|
#     #   @out_io.puts "%08b" %b

      
#     # end

#   end

#   @out_io.close

#   return @in_io
# end

 # get_io

 # puts @in_io.read

 

 def get_io
  
  @tracks.each do |track|
     data = IO.read(track)

     @in_io.write data
    # data.bytes do |b|
    #   @out_io.puts "%08b" %b

      
    # end

  end

  @in_io.close

  return @in_io
end