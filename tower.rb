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
    @target_area = 100

    # tower upgrading
    @upgrade = false

    # archer shooting
    @attack = false
    @attack_speed = 200

    # Archer
    @current_archer_frame = 0
    @current_archer_animation = IDEL
    @current_archer_level = 1
    @current_archer_direction = LEFT
    @archer_obj = Gosu::Image.load_tiles(ARCHER_SPRITE+@current_archer_level.to_s+'/'+@current_archer_direction+@current_animation+'.png', ARCHER_SPRITE_WIDTH, ARCHER_SPRITE_HEIGHT)
    @archer_pos = []
    @archer_order = ZOrder::ARCHER
  end

  def update
    if is_upgrading?
      self.upgrade_frame
    elsif is_attacking?
      self.attack_frame
    else 
      self.update_frame
      self.update_arhcer_direction if update_direction([800,600])
    end
  end

  def draw
    self.draw_archer_tower
    draw_circle(@pos[0], @pos[1], @target_area, Gosu::Color::rgba(255,255,0,128), ZOrder::OBJECT) if @highlight
  end

  def draw_archer_tower
    if !@pos.empty?
      @obj[@current_frame].draw(center_x(@pos[0]), center_y(@pos[1]), @order) # for tower
      @archer_obj[@current_archer_frame].draw(center_x(@archer_pos[0], true), center_y(@archer_pos[1], true), @archer_order) # for archer
    end
  end

  def upgrade
    return if @current_level >= MAX_TOWER_LEVEL # if max level, don't upgrade

    @upgrade = true
    # For Tower
    previous_level = @current_level
    @current_level += 1
    @current_frame = 0
    @obj = Gosu::Image.load_tiles(TOWER_SPRITE+'upgrade/'+previous_level.to_s+'_'+@current_level.to_s+'.png', TOWER_SPRITE_WIDTH, TOWER_SPRITE_HEIGHT)
    @target_area += 10

    # For Archer
    @archer_order = ZOrder::BACKGROUND # to make the archer disppear when the tower is upgrading
    if @current_level == 3 || @current_level == 6
      @current_archer_level += 1 
    end
    update_archer_pos
    # passed
  end

  def is_upgrading?
    return @upgrade
  end

  def upgrade_frame
    if @current_frame == @obj.size-1  
      # make default frame and animation
      @upgrade = false

      # For Tower
      @obj = Gosu::Image.load_tiles(TOWER_SPRITE+@current_level.to_s+'/'+@current_animation+'.png', TOWER_SPRITE_WIDTH, TOWER_SPRITE_HEIGHT) 
      @current_frame = 0

      # For Archer
      unless @current_level == 4 || @current_level == 7
        @archer_order = ZOrder::ARCHER
      end
      @archer_obj = Gosu::Image.load_tiles(ARCHER_SPRITE+@current_archer_level.to_s+'/'+@current_archer_direction+@current_animation+'.png', ARCHER_SPRITE_WIDTH, ARCHER_SPRITE_HEIGHT)
      @current_archer_frame = 0
    end 
    update_frame
  end

  def update_ZOrder(x,y)
    if (TOWER_CENTER.index([x,y])+1) % 2 == 0
      @order = ZOrder::TOWER_DOWN
    else
      @order = ZOrder::TOWER_UP
    end
  end

  def update_archer_pos
    @archer_pos[1] -= 10 if @current_level == 2
    @archer_pos[1] -= 10 if @current_level == 3
    @archer_pos[1] -= 5 if @current_level == 5
  end

  def update_frame
    @current_frame = (Gosu::milliseconds / FRAME_DELAY) % @obj.size
    @current_archer_frame = (Gosu::milliseconds / FRAME_DELAY) % @archer_obj.size
    @current_archer_frame = (Gosu::milliseconds / @attack_speed) % @archer_obj.size if is_attacking?
    @current_archer_frame = @archer_obj.size - 1 - (Gosu.milliseconds / @attack_speed) % @archer_obj.size if is_attacking? && @current_archer_direction == RIGHT
  end

  def attack
    @attack = true 

    # For Archer
    @current_archer_animation = ATTACK
    @current_archer_frame = 0
    @archer_obj = Gosu::Image.load_tiles(ARCHER_SPRITE+@current_archer_level.to_s+'/'+@current_archer_direction+@current_archer_animation+'.png', ARCHER_SPRITE_WIDTH, ARCHER_SPRITE_HEIGHT)
    @current_archer_frame = @archer_obj.size - 1 if @current_archer_direction = RIGHT
  end

  def is_attacking?
    return @attack
  end

  def attack_frame
    if (@current_archer_frame == @archer_obj.size-1 && @current_archer_direction != RIGHT) || (@current_archer_frame == 0 && @current_archer_direction == RIGHT)
      @attack = false
      @current_archer_animation = IDEL
      @archer_obj = Gosu::Image.load_tiles(ARCHER_SPRITE+@current_archer_level.to_s+'/'+@current_archer_direction+@current_archer_animation+'.png', ARCHER_SPRITE_WIDTH, ARCHER_SPRITE_HEIGHT)
      @current_archer_frame = 0
    end
    update_frame
  end

  def update_direction(direction)
    direction = (Vector.elements(direction) - Vector.elements(@archer_pos)).normalize
    previous_direction = @current_archer_direction
    angle = Math.atan2(direction[1], direction[0]).to_f
    if angle > -Math::PI/4 && angle <= Math::PI/4
      @current_archer_direction = RIGHT
    elsif angle > Math::PI/4 && angle <= 3*Math::PI/4
      @current_archer_direction = DOWN
    elsif angle > 3*Math::PI/4 || angle <= -3*Math::PI/4
      @current_archer_direction = LEFT
    else
      @current_archer_direction = UP
    end
    return previous_direction != @current_archer_direction
  end

  def update_arhcer_direction
    @archer_obj = Gosu::Image.load_tiles(ARCHER_SPRITE+@current_archer_level.to_s+'/'+@current_archer_direction+@current_archer_animation+'.png', ARCHER_SPRITE_WIDTH, ARCHER_SPRITE_HEIGHT)
  end

  def get_target(target)
    @target = target
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
      y - (@archer_obj[@current_archer_frame].height / 2)-5
    else
      y - (@obj[@current_frame].height - @obj[@current_frame].height / 4)
    end
  end
end