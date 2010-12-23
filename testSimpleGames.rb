require "./simplegames.rb"
include SimpleGames

class Screen
  def down_button
    $sprites[0].y += 10
  end
  
  def up_button
    $sprites[0].y -= 10
  end
  
  def right_button
    $sprites[0].x += 10
  end
  
  def left_button
    $sprites[0].x -= 10
  end
end

screen = Screen.new
sprite0 = Sprite.new("forward.png", screen)
screen.show