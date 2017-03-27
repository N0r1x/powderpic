require "./powderpic/*"
require "option_parser"

module Powderpic
  time=3.0
  timetemp=0.0
  filename=""
  run=false
  OptionParser.parse! do |parser|
    parser.banner = "Usage: powderpic [arguments]"
    parser.on("-f NAME", "Specifies the filename. Program will not run without this argument"){ |name| filename = name }
    parser.on("-t TIMER", "Specifies the time the terminal sleeps on the picture. If not given declared, sleeps for 3 seconds") { |timer| timetemp = timer.to_f }
    parser.on("-h", "--help", "Show this help") { puts parser }
  end
  if timetemp>0.0
    time=timetemp
  end
  if filename!=""
    heightoutput=`tput lines`
    widthoutput=`tput cols`
    heightstring=heightoutput[/^[0-9]*$/]
    widthstring=widthoutput[/^[0-9]*$/]
    height=heightstring.to_i
    width=widthstring.to_i
    ps=PictureSampler.new(filename,width,height)
    ps.sample
    string=ps.toString
    STDOUT.print string
    sleep time
  end
end
