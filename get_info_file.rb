module TestModule
  def mytest
    t = 'hello'
  end


  def get_frame_info track

    response = []

    id3v1 = nil
    id3v2 = nil

    id3v1_start = 0
    id3v1_end = nil

    id3v2_start = 0
    id3v2_end = 1024

    audio_version_id = ''
    layer_index = ''
    bitrate_index = ''
    sampling_rate_index = ''
    channel_mode = ''

    f = File.open(track, "r:binary")

    # start_id3v1 = f.size - 128

    # id3v1 = IO.read(f,id3v1_end,start_id3v1)
     id3v2 = IO.read(f,id3v2_end,id3v2_start)

    title = ''
    byte = ''
    titles = []

    n=0
    while (f.read(4,byte))
       
        if (byte.bytes[0] == 255 && 
              byte.bytes[1] == 255 &&
                byte.bytes[2] >= 224)
          title = ''
          byte.bytes.map {|b| title+= "%08b" % b }
          titles.push title
          n+=1 
        end 
      break if n == 4         
    end

    titles.each do |t|

      # get audio version id MPEG
          # 11-12
        case 
        when t[11] == 0 && t[12] == 0
          audio_version_id = 'MPEG-2.5'
        when t[11].to_i == 0 && t[12].to_i == 1
          audio_version_id = 'NONE'
        when t[11].to_i == 1 && t[12].to_i == 0
          audio_version_id = 'MPEG-2'
         when t[11].to_i == 1 && t[12].to_i == 1
           audio_version_id = 'MPEG-1'
        end

      # get layer_index
          # 13-14
        case 
        when t[13] == 0 && t[14] == 0
          layer_index = 'NONE'
        when t[13].to_i == 0 && t[14].to_i == 1
          layer_index = '3'
        when t[13].to_i == 1 && t[14].to_i == 0
          layer_index = '2'
         when t[13].to_i == 1 && t[14].to_i == 1
           layer_index = '1'
        end

        # get bitrate_index
        # 16-19

        case 
        when t[16] == 0 && t[17] == 0 && t[18] == 0 && t[19] == 0
          bitrate_index = 'NONE'
        when t[16] == 0 && t[17] == 0 && t[18] == 0 && t[19] == 0
          bitrate_index = '3'
        when t[16] == 0 && t[17] == 0 && t[18] == 0 && t[19] == 0
          bitrate_index = '2'
         when t[16] == 0 && t[17] == 0 && t[18] == 0 && t[19] == 0
           bitrate_index = '1'
        # else
        #   layer_index = "#{t[13]}#{t[14]}"
        end

        # sampling_rate_index
        # 20-21
        # 00 -> 44000Gzh
        # ...
        # 
        case 
        when t[16] == 0 && t[17] == 0 
          bitrate_index = 'NONE'
        when t[16] == 0 && t[17] == 0 
          bitrate_index = '3'
        when t[16] == 0 && t[17] == 0 
          bitrate_index = '2'
         when t[16] == 0 && t[17] == 0 
           bitrate_index = '1'
        # else
        #   layer_index = "#{t[13]}#{t[14]}"
        end

        #channel_mode
        # 24-25 bit
        # 00 -> Stereo
        # 01 -> Joint Stereo
        # 10 -> Dual channel
        # 11 -> Mono
        case 
        when t[16] == 0 && t[17] == 0 
          bitrate_index = 'NONE'
        when t[16] == 0 && t[17] == 0 
          bitrate_index = '3'
        when t[16] == 0 && t[17] == 0 
          bitrate_index = '2'
         when t[16] == 0 && t[17] == 0 
           bitrate_index = '1'
        # else
        #   layer_index = "#{t[13]}#{t[14]}"
        end
      
    end
        
        
        h = {
          file_name: File.basename(f, '.mp3'),
          file_size: f.size,
          audio_version_id: audio_version_id,
          layer_index: layer_index
          # frames: frames
          }

        response.push h
  end      
end