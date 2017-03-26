require "stumpy_png"
class PictureSampler
  property canvas : StumpyCore::Canvas,str : String, sampled : Array(Array(Int32)), width , height
  def initialize(filename : String ,width : Int32,height : Int32)
    @width=width
    @canvas=StumpyPNG.read(filename)
    @height=height
    @sampled=Array(Array(Int32)).new(@canvas.width) { Array(Int32).new(@canvas.height,0) }
    @str=""
    puts "initialized"
  end
  def sampler
    (0...@canvas.width).each do |x|
      (0...@canvas.height).each do |y|
        r, g, b = @canvas[x, y].to_rgb8
        @sampled[x][y]=rgbtoansi(r,g,b)
      end
    end
  end
  def toString
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

  private def colorize(colornumber,text)
    #inspired by http://stackoverflow.com/questions/1489183/colorized-ruby-output
    "\e[48;5;#{colornumber}m#{text}\e[0m"
  end
end
