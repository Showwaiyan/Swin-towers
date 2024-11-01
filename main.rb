require 'gosu'
require 'matrix'
require_relative 'constant.rb'
require_relative 'enemy.rb'

module ZOrder
  BACKGROUND, OBJECT, TOWER_UP, ENEMY, TOWER_DOWN, UI = *0..5
end

class Game < Gosu::Window
  def initialize
    super(SCREEN_WIDTH, SCREEN_HEIGHT)
    self.caption = 'Swin Towers'
    @bg = Gosu::Image.new('Assets/map/map.png')
    @enemies = []
    @last_spawn = Gosu.milliseconds
    @current_wave = 1
    @wave_file = File.open(WAVE_FILE + @current_wave.to_s + '.txt', 'r')
  end
  
  def button_down(id)
    case id
      when  Gosu::KB_ESCAPE # Instantly close the game, just for prototype version
        close
    end
  end

  def update
    if Gosu.milliseconds - @last_spawn > SPAWN_DELAY && !@wave_file.eof?
      ## Spawn enemy by reading the wave file with delay
      @enemies << Enemy.new(@wave_file.gets.chomp)
      @last_spawn = Gosu.milliseconds

    end

    @enemies.compact! 
    @enemies.each { |enemy| enemy.update }
    @enemies.delete_if { |enemy| enemy.check_path_end? || enemy.can_destory? }

    # Update wave if all enemies are spawned and cleared from the map
    # follwoing code will be commented until the official wave files are created
    # update_wave if @wave_file.eof? && @enemies.empty? 
  end

  def draw
    @bg.draw(0, 0, ZOrder::BACKGROUND)
    @enemies.each { |enemy| enemy.draw }
  end

  def update_wave
    @current_wave += 1
    @wave_file = File.open(WAVE_FILE + @current_wave.to_s + '.txt', 'r')
  end
end

Game.new.show