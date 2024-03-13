require './get_info_file'

 @tracks = Dir['/home/se/Documents/HDT RADIO ONE/tracks/*.mp3']
#@tracks = Dir['/home/se/Documents/HDT RADIO ONE/tracks/Red Hot Chili Peppers - 01 Under The Bridge (Album Version).mp3']


# in_io = IO.new(1, "w+")
# out_io = IO.new(in_io, "r")

# @out_io, @in_io = IO.pipe

@in_io = STDIN
@out_io = STDOUT


def get_io
  
  @tracks.each do |track|
     data = IO.read(track)

     # data = File.open(track, "r:binary")
    @out_io.puts data.bytes

  end

  @out_io.close

  return @in_io
end

# get_io

# puts @in_io.read