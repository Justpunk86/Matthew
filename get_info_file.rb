require './get_frame_info'

@playlist_dir = '/home/se/Documents/projects/HDT RADIO ONE/tracks/*.mp3' 

@tracks = []

 # module TestModule

  def mytest
    puts 'hello'
    sleep(3)
  end


def get_playlist
  tracks = Dir['/home/se/Documents/projects/HDT RADIO ONE/tracks/*.mp3' ]
end

 # end

  def download_sleep track
    duration = get_track_duration track
    sleep(duration*0.03)
  end

  def get_track track
    start = 4096
    step = 1044 * 40

    # if(tracks.length != 0)

    #   track = tracks.shift
      f = File.open(track, "r:binary")
      data_file = []
      # f = File.open(track, "r:utf-8")
      # f = IO.binread(track)
      # data_file = f.read
      
    # else
    #   data_file = nil
    # end
    
    # new_io = IO.new(1, "w")
    # data_file.bytes {|b| new_io.write b }

    0.upto(10198) do |fr|
        data_file[fr] = IO.read(f,step,start)
        start += step
    end
    
    f.close
    
    return data_file
  end

  def get_track_duration track_data

    # f = File.open(track, "r:binary")

    data_file = track_data

    # file_size = data_file.bytes.count
    
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

 # @tracks = Dir['/home/se/Documents/projects/HDT RADIO ONE/tracks/*.mp3']
 # @tracks = Dir['/home/se/Documents/projects/HDT RADIO ONE/tracks/Red Hot Chili Peppers - 01 Under The Bridge (Album Version).mp3'] 

 #  @tracks.each do |track|
 #    arr = get_track track

 #    n = 0
 #    arr.each do |fr| 
 #      n += 1
 #      puts "#{n}:"
 #      puts fr
 #      break if n == 15
 #    end

 #  end 