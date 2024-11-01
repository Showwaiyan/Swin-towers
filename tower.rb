require 'gosu'
require 'matrix'
require_relative 'constant.rb'

class Tower
  def initialize
    @current_frame = 0
    @current_level = 1
    @current_animation = IDEL
    @obj = Gosu::Image.load_tiles(TOWER_SPRITE+@current_level.to_s+'/'+@current_animation+'.png', TOWER_SPRITE_WIDTH, TOWER_SPRITE_HEIGHT)
    # @pos = 
  end

  def update
    #passed
  end

  def draw
    #passed
  end

  def update_frame
    @current_frame = (Gosu::milliseconds / FRAME_DELAY) % @obj.size
  end

  def draw_overlay(mouse_x, mouse_y)
    @obj[0].draw(center_x(mouse_x), center_y(mouse_y), ZOrder::TOWER_DOWN)
    draw_circle(mouse_x, mouse_y, @obj[0].width/2, Gosu::Color.rgba(0, 0, 0, 128), ZOrder::TOWER_DOWN)
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

  # center the tower image
  def center_x(x)
    x - (@obj[@current_frame].width / 2)
  end
  def center_y(y)
    y - (@obj[@current_frame].height - @obj[@current_frame].height / 4)
  end
end