require "rubygems"
require "gosu"

include Gosu

class Sprite
  attr_accessor :x, :y
  
  def initialize(image, target_window, x = 0, y = 0)
    begin
      @image = Image.new(target_window, image.to_s, false)
    rescue RuntimeError
      puts "Image file is does not exist. No Sprites were created."
      exit
    end
    @x = x
    @y =y
  end
  
end

class Screen < Gosu::Window
  
  def initialize (height = 800, width = 600, fullscreen = false, title = "A Simple Game")
    super(height,width,fullscreen)
    self.caption = title
  end
  
  def button_down(id)
    if id == Button::KbEscape
      close
    end
  end
  
end

