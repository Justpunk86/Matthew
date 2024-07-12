#slice_mp3.rb

tracks = Dir['/home/se/Documents/projects/HDT RADIO ONE/tracks/*.mp3']
dir_list = '/home/se/Documents/projects/HDT RADIO ONE/tracks/playlist'
segment_time = 1


cmd = ""

tracks.each do |track|
  cmd = "ffmpeg -i '#{track}' -f segment -sc_threshold 0 -segment_time #{segment_time} " \
        "-segment_list '#{dir_list}/playlist.txt' -acodec libmp3lame " \
        "-ac 2 -ab 320k -y '#{dir_list}/out%d.mp3'"
  # os = Kernel.`(cmd)  
  `#{cmd}`
  # puts os.length
end





