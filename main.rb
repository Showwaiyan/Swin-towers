require 'gosu'

SCREEN_WIDTH = 1024
SCREEN_HEIGHT = 768

module ZOrder
  BACKGROUND, OBJECT, CHAR, UI = *0..3
end

class Game < Gosu::Window
  def initialize
    super(SCREEN_WIDTH, SCREEN_HEIGHT)
    self.caption = 'Swin Towers'
    @bg = Gosu::Image.new('Assets/map_assets/map.png')
  end
  
  def button_down(id)
    close if id == Gosu::KB_ESCAPE
  end

  def update
  end

  def draw
    @bg.draw(0, 0, ZOrder::BACKGROUND)
  end
end

Game.new.show