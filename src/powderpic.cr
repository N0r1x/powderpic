require "./powderpic/*"

module Powderpic

  ps=PictureSampler.new("test.png",0,0)
  ps.sampler
  string=ps.toString
  STDOUT.print string
  sleep 3
  #picturesampling
  # heightoutput=`tput lines`
  # widthoutput=`tput cols`
  # heightstring=heightoutput[/^[0-9]*$/]
  # widthstring=widthoutput[/^[0-9]*$/]
  # height=heightstring.to_i
  # width=widthstring.to_i
  # filling ="#{"0" * width}\n"
  # STDOUT.print "#{filling*height}"
  # filling ="#{"0" * width}\n"
  # sleep 3
  # STDOUT.print "#{filling*height}"
end
