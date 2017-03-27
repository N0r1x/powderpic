require "stumpy_png"
class PictureSampler
  property canvas : StumpyCore::Canvas,str : String, sampled : Array(Array(Int32)), width : Int32 , height : Int32
  def initialize(filename : String ,width : Int32,height : Int32)
    @canvas=StumpyPNG.read(filename)
    puts "width ...."
    @width=closestDivisor(@canvas.width, width)
    puts "height ...."
    @height=closestDivisor(@canvas.height, height)
    @sampled=Array(Array(Int32)).new(@width) { Array(Int32).new(@height,0) }
    @str=""
    puts "initialized"
  end
  def sample
    columnsamples=@canvas.height/@height
    rowsamples=@canvas.width/@width
    puts "#{columnsamples} #{@canvas.height} #{@height}"
    puts "#{rowsamples} #{@canvas.width} #{@width}"
    (0...@width).each do |x|
      (0...@height).each do |y|
        r=0
        g=0
        b=0
        (0...rowsamples).each do |s|
          (0...columnsamples).each do |t|
            if(((x*rowsamples)+s)>@canvas.width||((y*columnsamples)+t)>@canvas.height)
              puts "ERROR"
              puts "x*rowsamples+s #{x*rowsamples+s} width #{@canvas.width} x #{x} rowsamples #{rowsamples} s #{s}"
              puts "y*columnsamples+t #{y*columnsamples+t} height #{@canvas.height}"
            end
            r0, g0, b0 = @canvas[(x*rowsamples)+s, (y*columnsamples)+t].to_rgb8
            r+=r0
            g+=g0
            b+=b0
          end
        end
        r/=columnsamples*rowsamples
        g/=columnsamples*rowsamples
        b/=columnsamples*rowsamples
        @sampled[x][y]=rgbtoansi(r,g,b)
      end
    end
  end
  def toString
    puts "Sampled[0].size"
    puts @sampled[0].size
    puts "Sampled.size"
    puts @sampled.size
    (0...@sampled[0].size).each do |y|
      (0...@sampled.size).each do |x|
        @str=@str+colorize(@sampled[x][y]," ")
      end
      @str=@str+"\n"
    end
    @str=@str+"\n"
    return @str
  end

  private def rgbtoansi(r,g,b)
    sample=16
    sample+=36*(r/43)
    sample+=6*(g/43)
    sample+=(b/43)
    return sample
  end
  private def closestDivisor(big, small)
    puts small
    while big % small != 0
      small-=1
      puts small
    end
    return small
  end
  private def colorize(colornumber,text)
    #inspired by http://stackoverflow.com/questions/1489183/colorized-ruby-output
    "\e[48;5;#{colornumber}m#{text}\e[0m"
  end
end
