require "./simplegames.rb"
include SimpleGames

class Screen
  def down_button
    unless @sprites[0].y >= @height
      @sprites[0].y += 10
    end
  end
  
  def up_button
    unless @sprites[0].y == 0
      @sprites[0].y -= 10
    end
  end
  
  def right_button
    unless @sprites[0].x >= @width
      @sprites[0].x += 10
    end
  end
  
  def left_button
    unless @sprites[0].x == 0
      @sprites[0].x -= 10
    end
  end
  
  def draw
    @sprites.each { |sprite| sprite.draw }

    @font.draw("Y: #{@sprites[0].y} X: #{@sprites[0].x}", 10, 10, 2, 1.0, 1.0, 0xffffffff)
  end
end

screen = Screen.new(1280,1025)
sprite0 = Sprite.new("forward.png", screen)
screen.show