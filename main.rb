require 'gosu'
require 'matrix'
require_relative 'constant.rb'
require_relative 'enemy.rb'
require_relative 'tower.rb'

module ZOrder
  BACKGROUND, OBJECT, TOWER_UP, ENEMY, TOWER_DOWN, ARCHER, UI = *0..6
end

class Game < Gosu::Window
  def initialize
    super(SCREEN_WIDTH, SCREEN_HEIGHT)
    self.caption = 'Swin Towers'
    @bg = Gosu::Image.new('Assets/map/map.png')
    
    # Enemy
    @enemies = []
    @last_spawn = Gosu.milliseconds
    @current_wave = 1
    # @wave_file = File.open(WAVE_FILE + @current_wave.to_s + '.txt', 'r')

    # Tower
    @towers = []
    @is_tower_overlay = false # indicate that tower is just overlay
    @can_create_tower = false # indicate that tower is actually built, not just overlay
  end
  
  def button_down(id)
    case id
      when  Gosu::KB_ESCAPE # Instantly close the game, just for prototype version
        close
      # Testing
      when Gosu::KB_SPACE
        @is_tower_overlay = !@is_tower_overlay
      when Gosu::MS_LEFT
        @can_create_tower = true
    end
  end

  def update
    # following code will be uncommented until the official wave files are created
    # spawn_enemy

    @enemies.compact! 
    @enemies.each { |enemy| enemy.update }
    @enemies.delete_if { |enemy| enemy.check_path_end? || enemy.can_destory? }

    # Update wave if all enemies are spawned and cleared from the map
    # follwoing code will be commented until the official wave files are created
    # update_wave if @wave_file.eof? && @enemies.empty? 
  end

  def draw
    @bg.draw(0, 0, ZOrder::BACKGROUND)
    @towers.each { |tower| tower.draw }
    @enemies.each { |enemy| enemy.draw }

    # Draw Tower Overlay for visualizing the tower placement
    draw_sample_tower(mouse_x,mouse_y) if @is_tower_overlay
  end

  def spawn_enemy
    if Gosu.milliseconds - @last_spawn > SPAWN_DELAY && !@wave_file.eof?
      ## Spawn enemy by reading the wave file with delay
      @enemies << Enemy.new(@wave_file.gets.chomp)
      @last_spawn = Gosu.milliseconds
    end
  end

  def update_wave
    @current_wave += 1
    @wave_file = File.open(WAVE_FILE + @current_wave.to_s + '.txt', 'r')
  end

  def draw_sample_tower(mouse_x, mouse_y)
    tower = Tower.new
    if check_tower_placeable(tower, mouse_x, mouse_y) && @can_create_tower
      @towers << tower
      TOWER_CENTER.delete([tower.get_pos_x, tower.get_pos_y])
      @create_tower = false
      @is_tower_overlay = false
    else
      # not to create tower even if the mouse is clicked
      # if not, the tower will automatically be created when it reach the valid area
      @can_create_tower = false
    end
  end

  def check_tower_placeable(tower, mouse_x, mouse_y)

    color = Gosu::Color.rgba(255, 0, 0, 128) # defualt color is red for invalid placement
    valid = false

    TOWER_CENTER.each do |center|
      center_x = center[0]
      center_y = center[1]
      leftX = center_x - TOWER_SPRITE_WIDTH / 2
      topY = center_y - TOWER_SPRITE_HEIGHT / 4
      rightX = center_x + TOWER_SPRITE_WIDTH / 2
      bottomY = center_y + TOWER_SPRITE_HEIGHT / 4

      # Check if the cursor is in the valid area
      if is_cursor_in_area?(leftX, topY, rightX, bottomY, mouse_x, mouse_y)
        # the mosue cursor is in the valid area
        mouse_x = center_x
        mouse_y = center_y
        tower.update_pos(center_x, center_y)
        tower.update_ZOrder(center_x, center_y)
        color = Gosu::Color.rgba(0, 255, 0, 128)
        valid = true
        break
      end
    end

    tower.draw_overlay(mouse_x, mouse_y, color)
    return valid
  end

  def is_cursor_in_area?(leftX, topY, rightX, bottomY, mouse_x, mouse_y)
    if mouse_x > leftX && mouse_x < rightX && mouse_y > topY && mouse_y < bottomY
     return true
    else
     return false
    end
 end
end

Game.new.show