require './get_frame_info'

# module TestModule

  # def mytest
  #   t = 'hello'
  # end

# end

  def get_track track
    f = File.open(track, "r:binary")
    # f = IO.binread(track)
    data_file = f.read
    f.close
    # new_io = IO.new(1, "w")
    # data_file.bytes {|b| new_io.write b }

    
     return data_file
  end

  def get_track_duration track

    # f = File.open(track, "r:binary")

    data_file = get_track track

    file_size = data_file.bytes.count
    
    hash_props = get_audio_props data_file

    # # Duration = Number of Frames * Samples Per Frame / Sampling Rate

    duration = hash_props[:vbr_num_frames] * 
        hash_props[:samples_per_frame] / 
        hash_props[:sampling_rate_index].to_i

    duration.round(2)

    # hash_props.each do |props|
    #   puts props.inspect
    # end

  end   



# include TestModule

 # @tracks = Dir['/home/se/Documents/HDT RADIO ONE/tracks/*.mp3']

 #  @tracks.each do |track|
 #   get_track_duration track

 #  end 