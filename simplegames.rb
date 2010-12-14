module SimpleGames
# This module abstracts away all but the simplest parts of a 2D game
# intended to aid children in developing games with Ruby
#--
# Copyright (c) 2010 Will Luongo
# Licensed under the MIT license
require "rubygems"
require "gosu"

include Gosu


=begin rdoc
A Sprite object is a simple flat image that you can move around the screen.
Common applications for sprites include players, enemies, bullets, and scenary.
=end
class Sprite
  attr_accessor :x, :y
  
  def initialize(image, target_window, x = 0, y = 0) # :
    begin
      @image = Image.new(target_window, image.to_s, false)
    rescue RuntimeError
      puts "Image file is does not exist. No Sprites were created."
      exit
    end
    @x = x
    @y =y
  end
  
=begin rdoc
The draw method draws the image loaded onto the screen.
=end
  def draw
    @image.draw(@x, @y, 1)
  end
  
end

=begin rdoc
The Screen object is the main view into the world of the game.
Typically there will only be one of these per game.
=end
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

end