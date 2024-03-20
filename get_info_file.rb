require './get_frame_info'
require 'io/console'

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
    # start = 4096
    # step = 1044 * 40

    # if(tracks.length != 0)

    #   track = tracks.shift
    f = File.open(track, "r:binary")
    # data_file = []
      # f = File.open(track, "r:utf-8")
      # f = IO.binread(track)
    track_data = f.read
      
    # else
    #   data_file = nil
    # end
    
    # new_io = IO.new(1, "w")
    # data_file.bytes {|b| new_io.write b }

    # 0.upto(10198) do |fr|
    #     data_file[fr] = IO.read(f,step,start)
    #     start += step
    # end
    
    f.close
    
    return track_data
  end

  def get_track_duration track_data

    # f = File.open(track, "r:binary")

    # data_file = track_data

    # file_size = data_file.bytes.count
    
    track_props = get_audio_props track_data

    # # Duration = Number of Frames * Samples Per Frame / Sampling Rate

    duration = track_props[:vbr_num_frames] * 
        track_props[:samples_per_frame] / 
        track_props[:sampling_rate_index]

    duration.round(2)

    # hash_props.each do |props|
    #   puts props.inspect
    # end

  end   

# записываем трек в массив по секундам
  def get_data_track_second track_data

    track_props = get_audio_props track_data

    id3v2_length = track_props[:id3v2_length]
    bitrate_index = track_props[:bitrate_index]
    sampling_rate_index = track_props[:sampling_rate_index]
    samples_per_frame = track_props[:samples_per_frame]
    padding = track_props[:padding]
    vbr_num_frames = track_props[:vbr_num_frames]


    # длина фрейма в байтах
    #FrameLengthInBytes = 144 * bitrate_index / sampling_rate_index + Padding 
    frame_length_in_bytes = 144 * bitrate_index * 1000 / sampling_rate_index + padding

    # длина фрейма в байтах v2
    #Frame Size = 
    # ( (samples_per_frame / 8 * bitrate_index) / 
    # sampling_rate_index) + padding

    # frame_length_in_bytes_2 = ( (samples_per_frame / 8 * bitrate_index * 1000) /
    #     sampling_rate_index ) + padding

    start_play = id3v2_length

    #кол-во байт в секунду
    bytes_one_second = bitrate_index * 1000 / 8

    # считаем кол-во фремов в 1-й секунде    
    frames_one_second = bytes_one_second / frame_length_in_bytes

    # получаем кол-во фреймов в байтах для чтения 1-й секунды
    step = frame_length_in_bytes * frames_one_second

    data_file = []

    #  0.upto(10198) do |fr|
    #     data_file[fr] = IO.read(f,step,start)
    #     start += step
    # end

    # Нужно записать в массив данные по секундам

    vbr_num_frames

    c = 0
    title_byte = ''
    # puts track_data.length
    

    next_start = start_play
    next_end = start_play + step

    loop {

      

        # puts c

        # puts next_start
        # puts next_end
      

      data_file.push track_data.byteslice(next_start..next_end)

      next_start = next_end
      next_end = next_end + step

        # puts data_file[c].length

        # c += 1


        # break if c == 2

      break if track_data.length <= next_end

    }

    
      # puts data_file[266]

      # puts data_file[266].length

      # puts data_file.length

        
    # puts "#{frame_length_in_bytes} <===> #{frame_length_in_bytes_2}"
    # "frame_length_in_bytes = #{frame_length_in_bytes}, 
    # one_second = #{bytes_one_second},
    # frames_one_second = #{frames_one_second},
    # step = #{step},
    # track_size = #{track_data.bytes.count - 4096 - 128},
    # c_fr = #{c_fr},
    # data_file = #{data_file[1]}"
    
    data_file

  end



# include TestModule

 # @tracks = Dir['/home/se/Documents/projects/HDT RADIO ONE/tracks/*.mp3']
 #  @tracks = Dir['/home/se/Documents/projects/HDT RADIO ONE/tracks/Red Hot Chili Peppers - 01 Under The Bridge (Album Version).mp3'] 

 #   @tracks.each do |track|
 
 #    # puts get_audio_props get_track track
 #    get_data_track_second get_track track

 #   end 