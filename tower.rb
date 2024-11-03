require 'gosu'
require 'matrix'
require_relative 'constant.rb'

class Tower
  def initialize
    @current_frame = 0
    @current_level = 1
    @current_animation = IDEL
    @obj = Gosu::Image.load_tiles(TOWER_SPRITE+@current_level.to_s+'/'+@current_animation+'.png', TOWER_SPRITE_WIDTH, TOWER_SPRITE_HEIGHT)
    @pos =  []

    # we need to dynamically change the ZOrder of the tower
    # becuase some tower will be upabove layer on enemy
    # and some tower will be downbelow layer on enemy
    # tower on the down side of path will be upabove layer on enemy
    # tower on the up side of path will be downbelow layer on enemy
    @order = nil

    # highligt flag for tower
    @highlight = false

    # Archer
    @current_archer_frame = 0
    @current_archer_animation = IDEL
    @current_archer_level = 1
    @current_archer_direction = LEFT
    @archer_obj = Gosu::Image.load_tiles(ARCHER_SPRITE+@current_archer_level.to_s+'/'+@current_archer_direction+@current_animation+'.png', ARCHER_SPRITE_WIDTH, ARCHER_SPRITE_HEIGHT)
    @archer_pos = []
  end

  def update
    #passed
    self.update_frame
  end

  def draw
    self.draw_archer_tower
    draw_circle(@pos[0], @pos[1], @obj[0].width/2, Gosu::Color::rgba(255,255,0,128), ZOrder::OBJECT) if @highlight
  end

  def draw_archer_tower
    if !@pos.empty?
      @obj[@current_frame].draw(center_x(@pos[0]), center_y(@pos[1]), @order) # for tower
      @archer_obj[@current_archer_frame].draw(center_x(@archer_pos[0], true), center_y(@archer_pos[1], true), ZOrder::ARCHER) # for archer
    end
  end

  def update_ZOrder(x,y)
    if (TOWER_CENTER.index([x,y])+1) % 2 == 0
      @order = ZOrder::TOWER_DOWN
    else
      @order = ZOrder::TOWER_UP
    end
  end

  def update_frame
    @current_frame = (Gosu::milliseconds / FRAME_DELAY) % @obj.size
  end

  def draw_overlay(mouse_x, mouse_y, color)
    @obj[0].draw(center_x(mouse_x), center_y(mouse_y), ZOrder::UI1)
    draw_circle(mouse_x, mouse_y, @obj[0].width/2, color, ZOrder::UI1)
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

  def update_pos(x, y)
    @pos[0] = x
    @pos[1] = y
    @archer_pos[0] = x
    @archer_pos[1] = y
  end

  # getter for tower position
  def get_pos_x
    return @pos[0]
  end
  def get_pos_y
    return @pos[1]
  end

  def is_clicked?(mouse_x, mouse_y)
    leftX = @pos[0] - TOWER_SPRITE_WIDTH / 2
    topY = @pos[1] - TOWER_SPRITE_HEIGHT / 4
    rightX = @pos[0] + TOWER_SPRITE_WIDTH / 2
    bottomY = @pos[1] + TOWER_SPRITE_HEIGHT / 4
    if is_clicked_in_area?(leftX, topY, rightX, bottomY, mouse_x, mouse_y)
      return true
    else
      return false
    end
  end

  def select_tower
    @highlight = true
  end

  def unselect_tower
    @highlight = false
  end

  def is_selected?
    return @highlight
  end

  def is_clicked_in_area?(leftX, topY, rightX, bottomY, mouse_x, mouse_y)
    if mouse_x > leftX && mouse_x < rightX && mouse_y > topY && mouse_y < bottomY
      return true
    else
      return false
    end
  end

  # center the tower image
  # flag is used to know whether the image is tower or archer
  # because tower and archer have different height and amount of frame
  def center_x(x, flag = false)
    if flag
      x - (@archer_obj[@current_archer_frame].width / 2)
    else
      x - (@obj[@current_frame].width / 2)
    end
  end
  def center_y(y, flag = false)
    if flag
      y - (@archer_obj[@current_archer_frame].height / 2)
    else
      y - (@obj[@current_frame].height - @obj[@current_frame].height / 4)
    end
  end
end