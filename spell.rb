require 'gosu'
require 'matrix'
require_relative 'constant.rb'

class Spell

  def initialize(spell)
    case spell
      when 'lightning'
        @obj = Gosu::Image.load_tiles(LIGHTNING_SPRITE, LIGHTNING_WIDTH, LIGHTNING_HEIGHT);
        @aoe = LIGHTING_AOE
    end

    @current_frame = 0
    @pos = []
    @overlay = false
    @start = false
    @last_frame_time = Gosu::milliseconds
  end

  def update
    update_frame if @start
  end

  def update_frame
    if is_start? && (Gosu::milliseconds - @last_frame_time >= FRAME_DELAY)
      @current_frame = (@current_frame + 1) % @obj.size
      @last_frame_time = Gosu::milliseconds
    end
  
    if @current_frame == @obj.size - 1
      @start = false
      @current_frame = 0
    end
  end

  def start_lighting
    @overlay = false
    @start = true
  end

  def draw
    @obj[@current_frame].draw(@pos[0]-LIGHTNING_WIDTH/2, @pos[1]-LIGHTNING_HEIGHT, ZOrder::SPELL) if is_start?
    draw_overlay if is_overlay?
  end

  def draw_overlay
      draw_circle(@pos[0], @pos[1], @aoe, Gosu::Color::rgba(255, 255, 255, 128), ZOrder::UI1) 
      Gosu::Image.new(LIGHTNING_BTN_IMG).draw(@pos[0]-46/2, @pos[1]-46/2, ZOrder::UI1)
  end

  def draw_circle(x, y, radius, color, z = 0, steps = 30)
    # To indicate by color that the tower can be placed or not
    angle_step = 2 * Math::PI / steps
    (0...steps).each do |i|
      angle1 = i * angle_step
      angle2 = (i + 1) * angle_step
  
      x1 = x + radius * Math.cos(angle1)
      y1 = y + radius * Math.sin(angle1)
      x2 = x + radius * Math.cos(angle2)
      y2 = y + radius * Math.sin(angle2)
  
      Gosu.draw_triangle(x, y, color, x1, y1, color, x2, y2, color, z)
    end
  end

  def clicked
    @overlay = true
  end

  def is_overlay?
    return @overlay
  end

  def is_start?
    return @start
  end

  def cancel_overlay
    @overlay = false
  end

  def update_pos(x, y)
    @pos = [x, y]
  end

  def is_enemy_in_range?(enemy)
    distance = Math.sqrt((enemy.get_pos_x - @pos[0])**2 + (enemy.get_pos_y - @pos[1])**2)
    return distance <= @aoe
  end

end