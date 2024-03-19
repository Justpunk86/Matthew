

def get_audio_props f

  # response = []
    
  id3v2_length = get_id3v2_length f
  
  
  title_byte = ''

  # get first title
  # title = IO.read(f,4,id3v2_length)
  title = f[id3v2_length..id3v2_length+4]

  # write title in binary format
  if (title.bytes[0] == 255 && title.bytes[1] >= 224)
      
    title.bytes.map {|b| title_byte+= "%08b" % b }
      
  end

  res1 = read_title title_byte
  res2 = read_vbr f

  res2.each do |k,v|
    res1[k] = v
  end

  res1[:samples_per_frame] = 1152

  res1

  # response.push read_title title_byte
  # response.push read_vbr f
  # response.push read_id3v2 f
    
end



def get_id3v2_length f

  id3v2_title_length = 10

  id3v2 = f[6..9]#IO.read(f,4,6)
  id3v2_byte = id3v2.bytes.map {|b| "%b" % b }
  
  id3v2_length = id3v2_byte.join("").to_i(2) + id3v2_title_length

end  


def read_vbr f
  vbr_offset = 32
  frame_title_length = 4
  id3v2_length = get_id3v2_length f

    vbr_start = id3v2_length + vbr_offset + frame_title_length

    # read vbr
    vbr_id = f[vbr_start..vbr_start+3]
    #IO.read(f,4,vbr_start)
    vbr_num_frames =  f[vbr_start+8..vbr_start+8+3]
    # IO.read(f,4,vbr_start+8).
                      .bytes
                      .map {|b| "%b" % b }.
                      join("").to_i(2)
    vbr_num_bytes = f[vbr_start+12..vbr_start+12+3]
    # IO.read(f,4,vbr_start+12).
                      .bytes.map {|b| "%b" % b }.
                      join("").to_i(2)

    h = {
        vbr_id: vbr_id,
        vbr_num_frames: vbr_num_frames,
        vbr_num_bytes: vbr_num_bytes
    }
end  



def read_title title

  h = {}
  
  audio_version_id = ''
  layer_index = ''
  bitrate_index = ''
  sampling_rate_index = ''
  channel_mode = ''

  # get audio version id MPEG
      # 11-12
    case 
    when title[11].to_i == 0 && title[12].to_i == 0
      audio_version_id = 'MPEG-2.5'
    when title[11].to_i == 0 && title[12].to_i == 1
      audio_version_id = 'NONE'
    when title[11].to_i == 1 && title[12].to_i == 0
      audio_version_id = 'MPEG-2'
     when title[11].to_i == 1 && title[12].to_i == 1
       audio_version_id = 'MPEG-1'
    end

  # get layer_index
      # 13-14
    case 
    when title[13].to_i == 0 && title[14].to_i == 0
      layer_index = 'NONE'
    when title[13].to_i == 0 && title[14].to_i == 1
      layer_index = '3'
    when title[13].to_i == 1 && title[14].to_i == 0
      layer_index = '2'
     when title[13].to_i == 1 && title[14].to_i == 1
       layer_index = '1'
    end

    # get bitrate_index
    # 16-19

    case 
    when title[16].to_i == 0 && title[17].to_i == 0 && title[18].to_i == 0 && title[19].to_i == 0
      bitrate_index = 'NONE'
    when title[16].to_i == 0 && title[17].to_i == 0 && title[18].to_i == 0 && title[19].to_i == 1
      bitrate_index = '32'
    when title[16].to_i == 0 && title[17].to_i == 0 && title[18].to_i == 1 && title[19].to_i == 0
      bitrate_index = '64'
    when title[16].to_i == 0 && title[17].to_i == 0 && title[18].to_i == 1 && title[19].to_i == 1
      bitrate_index = '96'
     when title[16].to_i == 0 && title[17].to_i == 1 && title[18].to_i == 0 && title[19].to_i == 0
       bitrate_index = '128'
    when title[16].to_i == 1 && title[17].to_i == 1 && title[18].to_i == 1 && title[19].to_i == 0
      bitrate_index = '320'
    when title[16].to_i == 1 && title[17].to_i == 1 && title[18].to_i == 1 && title[19].to_i == 1
      bitrate_index = 'NONE'
    else
      bitrate_index = 'other'
    end

    # sampling_rate_index
    # 20-21
    case 
    when title[20].to_i == 0 && title[21].to_i == 0 
      sampling_rate_index = '44100'
    when title[20].to_i == 0 && title[21].to_i == 1 
      sampling_rate_index = '48000'
    when title[20].to_i == 1 && title[21].to_i == 0 
      sampling_rate_index = '32000'
     when title[20].to_i == 1 && title[21].to_i == 1 
       sampling_rate_index = 'NONE'
    end

    #channel_mode
    # 24-25 bit
    case 
    when title[24].to_i == 0 && title[25].to_i == 0 
      channel_mode = 'Stereo'
    when title[24].to_i == 0 && title[25].to_i == 1
      channel_mode = 'Joint Stereo'
    when title[24].to_i == 1 && title[25].to_i == 0 
      channel_mode = 'Dual channel'
     when title[24].to_i == 1 && title[25].to_i == 1
       channel_mode = 'Mono'
    end

  # h[:title] = title
  
  h[:audio_version_id] = audio_version_id
  h[:layer_index] = layer_index
  h[:bitrate_index] = bitrate_index
  h[:sampling_rate_index] = sampling_rate_index
  h[:channel_mode] = channel_mode

  return h
    
end    

def read_id3v1 f

  # A 3 (0-2)   Tag identification. 
  # Must contain 'TAG' if tag exists and is correct.
  # B 30  (3-32)  Title
  # C 30  (33-62) Artist
  # D 30  (63-92) Album
  # E 4 (93-96) Year
  # F 30  (97-126)  Comment
  # G 1 (127) Genre

   

  id3v1_start = f.size - 128
  id3v1_end = nil

  id3v1 = IO.read(f,id3v1_end,id3v1_start)


  # id3v1_tag = IO.read(f,3,id3v1_start)
  
  # # id3v1_tag.bytes.map {|b| id3v1_tag+= "%08b" % b }.to_s

  # id3v1_title = IO.read(f,30,id3v1_start+3)

  # id3v1_artist = IO.read(f,25,id3v1_start+3+30)

  # id3v1_album = ''
  # IO.read(f,25,id3v1_start+3+30+30).
  #   bytes.map {|b| id3v1_album+= "%08b" % b }.
  #   join("").to_s

  # id3v1_year = ''
  # IO.read(f,25,id3v1_start+3+30+30).
  #   bytes.map {|b| id3v1_year+= "%08b" % b }.
  #   join("").to_i

  # h={
  #   id3v1_tag: id3v1_tag,
  #   id3v1_title: id3v1_title,
  #   id3v1_artist: id3v1_artist,
  #   id3v1: id3v1
  #   # id3v1_album: id3v1_album,
  #   # id3v1_year: id3v1_year
  # }

end

def read_id3v2 f
  id3v2_length = get_id3v2_length f

  id3v2 = IO.read(f,id3v2_length,0)
   # id3v2 = f.read(id3v2_length)

   # id3v2 = IO.read(f,4086,10)
     # puts id3v2
    
    # id3v2_songname_id = IO.read(f,4,10)
    # id3v2_author_id = IO.read(f,4,14)

    #  puts id3v2_songname_id

    #  puts id3v2_author_id

    # n=11
    # id3v2_songname.bytes do |b|
    #     print "#{n}: %08b" % b
    #   # if b != 0
    #      puts "%c" % b
    #     n += 1
    #   # end
    # end

end