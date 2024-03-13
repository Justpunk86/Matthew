# rd, rw = IO.pipe

# if fork
#   rw.close
#   puts "Parent got: #{rd.read}"
#   rd.close
#   Process.wait
# else
#   rd.close
#   puts "Sending message to parent"
#   rw.write "Hi Dad"
#   rw.close
# end

$stdout.print "h"
$stdout.flush
