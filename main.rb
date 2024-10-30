require 'gosu'
require 'matrix'
require_relative 'constant.rb'
require_relative 'enemy.rb'

module ZOrder
  BACKGROUND, OBJECT, CHAR, UI = *0..3
end

class Game < Gosu::Window
  def initialize
    super(SCREEN_WIDTH, SCREEN_HEIGHT)
    self.caption = 'Swin Towers'
    @bg = Gosu::Image.new('Assets/map/map.png')
  end
  
  def button_down(id)
    case id
      when  Gosu::KB_ESCAPE # Instantly close the game, just for prototype version
        close
    end
  end

  def update
    @enemies.compact!
    @enemies.each { |enemy| enemy.update }
    @enemies.delete_if { |enemy| enemy.check_path_end }
  end

  def draw
    @bg.draw(0, 0, ZOrder::BACKGROUND)
    @enemies.each { |enemy| enemy.draw }
  end
end

Game.new.show