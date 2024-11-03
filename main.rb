require 'gosu'
require 'matrix'
require_relative 'constant.rb'
require_relative 'enemy.rb'
require_relative 'tower.rb'
require_relative 'ui.rb'

module ZOrder
  BACKGROUND, OBJECT, TOWER_UP, ENEMY, TOWER_DOWN, ARCHER, UI0, UI1 = *0..7
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
    @overlay_tower = nil

    # UI
    @in_game_ui = [UI.new(TOWER_CREATE_BTN)]
  end
  
  def button_down(id)
    case id
      when  Gosu::KB_ESCAPE # Instantly close the game, just for prototype version
        close
      when Gosu::MS_LEFT
        # tower selected check
        @towers.each do |tower|
          if tower.is_clicked?(mouse_x, mouse_y) && @is_tower_overlay == false
            @towers.each { |tower| tower.de_select_tower } # make to select only one at a time
            tower.select_tower
          end
        end

        # tower creating
        if @is_tower_overlay
          # if tower is overlay, then left click will create the tower
          if @can_create_tower
            create_tower
            @is_tower_overlay = false
            @can_create_tower = false
          else
            # if tower is not in valid place, then left click will cancel the tower overlay
            @is_tower_overlay = false
          end
        end

        # in game button click event
        @in_game_ui.each do |btn|
          if btn.clicked?(mouse_x, mouse_y)
            case btn.get_ui_type
              when 'tower_create_button'
                return if TOWER_CENTER.empty? # if there is no place to build the tower
                # Show tower overlay 
                @is_tower_overlay = true
                # @not_placeable_tower = false
            end
          end
        end
        


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

    # UI
  end

  def draw
    # Draw UI
    @in_game_ui.each { |btn| btn.draw }

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
    @overlay_tower = Tower.new

    if is_tower_placeable(mouse_x, mouse_y)
      color = Gosu::Color.rgba(0, 255, 0, 128) # valid color is green
    else
      color = Gosu::Color.rgba(255, 0, 0, 128) # invalid color is red
    end

    @overlay_tower.draw_overlay(@overlay_tower.get_pos_x, @overlay_tower.get_pos_y, color)
  end

  def is_tower_placeable(mouse_x, mouse_y)

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
        @overlay_tower.update_pos(center_x, center_y)
        @overlay_tower.update_ZOrder(center_x, center_y)
        @can_create_tower = true
        return true
        break
      else
        @overlay_tower.update_pos(mouse_x, mouse_y)
      end
    end

    @can_create_tower = false
    return false
  end

  def create_tower
    @towers << @overlay_tower
    TOWER_CENTER.delete([@overlay_tower.get_pos_x, @overlay_tower.get_pos_y]) 
    @overlay_tower = nil
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