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
    attr_reader :bounding_height, :bounding_width
    
    def initialize(name, image, target_window, x = 0, y = 0, bounding_width = nil, bounding_height = nil) # :
      begin
        @image = Image.new(target_window, image.to_s, false)
      rescue RuntimeError
        puts "Image file #{image} does not exist. No Sprites were created."
        exit
      end
      bounding_height && @bounding_height = bounding_height
      bounding_width && @bounding_width = bounding_width
      bounding_height || @bounding_height = @image.height
      bounding_width || @bounding_width = @image.width
      
      @x = x
      @y =y
      target_window.sprites[name] = self
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
      @sprites = Hash.new
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
      @sprites.each_value { |sprite| sprite.draw }
    end
    
    def collide
      @sprites.each { |main_name, main_sprite|
        @sprites.each { |name, sprite|
          if main_name != name
            if distance(main_sprite.x, main_sprite.y, sprite.x, sprite.y) < 50 
              # puts "#{main_name} and #{name} collided!"
              return [main_name, name]
            else
              # puts "#{main_name} and #{name} failed to collide."
              # return [false, false]
            end

          end
        }
      }
      return [false, false]
    end
    
    def collision(target_one, target_two)
    	if @sprites[target_two].x + @sprites[target_two].bounding_width < @sprites[target_one].x
    		return false
		end
		if @sprites[target_two].x > @sprites[target_one].x + @sprites[target_one].bounding_width
			return false
		end
		
		if @sprites[target_two].y + @sprites[target_two].bounding_height < @sprites[target_one].y
			return false
		end
		if @sprites[target_two].y > @sprites[target_one].y + @sprites[target_one].bounding_height
			return false
		end
		
		return true
		
    end
    
    
    def down_button
      raise NotImplementedError, 'You need to make sure you implement the down_button method'
    end

    def up_button
      raise NotImplementedError, 'You need to make sure you implement the up_button method'
    end

    def right_button
      raise NotImplementedError,'You need to make sure you implement the right_button method'
    end

    def left_button
      raise NotImplementError, 'You need to make sure you implement the left_button method'
    end
    
  end

end