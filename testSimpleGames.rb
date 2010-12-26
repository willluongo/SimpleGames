require "./simplegames.rb"
include SimpleGames
class MyScreen < Screen
  def initialize
    super
    @lives = 5
  end
  def down_button
    unless @sprites[:ship].y >= @height
      @sprites[:ship].y += 10
    end
  end
  def up_button
    unless @sprites[:ship].y == 0
      @sprites[:ship].y -= 10
    end
  end 
  def right_button
    unless @sprites[:ship].x >= @width
      @sprites[:ship].x += 10
    end
  end
  def left_button
    unless @sprites[:ship].x == 0
      @sprites[:ship].x -= 10
    end
  end
  def draw
    super
    @font.draw("Lives: #{@lives}", 10, 10, 2, 1.0, 1.0, 0xffffffff)
    if @lives == 0
      @font.draw("GAME OVER", 100, 100, 2, 1.0, 1.0, 0xffffffff)
    end
  end
  def update
    super
    if @sprites[:asteroid].x > -10
      @sprites[:asteroid].x -= 20
    else
      # puts @sprites[:asteroid].x
      @sprites[:asteroid].x = 800
      @sprites[:asteroid].y = rand(600)
    end
    if collision(:ship, :asteroid)
      puts "Kaboom!"
      @lives -= 1
      if @lives == 0
        @sprites[:ship].x = 2000
        @sprites[:ship].y = 2000
      else
      @sprites[:ship].x = 10
      @sprites[:ship].y = 10
      end
    end
  end
end
screen = MyScreen.new
Sprite.new(:ship, "forward.png", screen)
Sprite.new(:asteroid, "asteroid.png", screen,800,rand(600))
puts "#{screen.sprites[:ship].height} high and #{screen.sprites[:ship].width}"
puts "#{screen.sprites[:asteroid].height} high and #{screen.sprites[:asteroid].width}"

screen.show