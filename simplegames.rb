=begin rdoc
This module abstracts away all but the simplest parts of a 
2D game to aid children in developing games with Ruby 

Copyright (c) 2010 Will Luongo
Licensed under the MIT license
=end

module SimpleGames

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
      target_window.sprites.push self
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
    attr_accessor :sprites
    def initialize (width = 800, height = 600, fullscreen = false, title = "A Simple Game")
      super(width,height,fullscreen)
      @height = height
      @width = width
      self.caption = title
      @sprites = Array.new
      @font = Font.new(self, "monospace", 40)

    end
    
=begin rdoc
The setup method creates an area of interaction.
It takes a single bool as an argument, but by default there is no "gravity"
=end
    def setup(gravity = false)
      @space = Space.new
      @space.damping = 0.0
      if gravity
        @space.gravity = Vec2.new(0.0, 25.0)
      end
    end
    
    def update
      # Perform the physics steps first
      # SUBSTEPS.times do
        ## Do Physics tasks here.  Collisions, forces from the environment, etc.
        
        # This tells chipmunk to calculate everything in the space for DTIME time.
       # @space.step(DTIME)
      
      ## Do Game Logic tasks here. See the Gosu Wiki (RubyChipmunkIntegration) for
      ## more details on what you might want to put here instead of above.
      if button_down? Gosu::Button::KbLeft or button_down? Gosu::Button::GpLeft then
        left_button
      end
      if button_down? Gosu::Button::KbRight or button_down? Gosu::Button::GpRight then
        right_button
      end
      if button_down? Gosu::Button::KbUp or button_down? Gosu::Button::GpButton0 then
        up_button
      end
      if button_down? Gosu::Button::KbDown
        down_button
      end

    end
    
    def button_down(id)
      if id == Button::KbEscape
        close
      end
    end
    
    def draw
        @sprites.each { |sprite| sprite.draw }
    end
    
    
    def down_button
      # Does nothing - should be overridden by progam
    end

    def up_button
      # Does nothing - should be overridden by progam
    end

    def right_button
      # Does nothing - should be overridden by progam
    end

    def left_button
      # Does nothing - should be overridden by progam
    end
    
  end

end

