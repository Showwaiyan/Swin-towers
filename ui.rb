require 'gosu'
require_relative 'constant.rb'

class UI
  def initialize(ui)
    @ui_type = ui # string of ui type which indicates to draw the specific page ui elements
    case @ui_type
      when 'tower_box_button'
        @tower_img = Gosu::Image.new(TOWER_SPRITE + '1/_Idel.png')
        @x = TOWER_BOX_X
        @y = TOWER_BOX_Y
        @width = TOEWR_BOX_WIDTH
        @height = TOWER_BOX_HEIGHT
    end
  end

  def update
    
  end

  def draw
    self.draw_ui_elements(@ui_type)
  end

  def  draw_ui_elements(ui) 
    case ui
      when 'tower_box_button'
        draw_tower_box
    end
  end

  def draw_tower_box
    # draw tower box border (border line)
    Gosu.draw_line(@x, @y, TOWER_BOX_BORDER_COLOR, @x + @width, @y, TOWER_BOX_BORDER_COLOR, ZOrder::UI1)               # Top
    Gosu.draw_line(@x, @y + @height, TOWER_BOX_BORDER_COLOR, @x + @width, @y + @height, TOWER_BOX_BORDER_COLOR, ZOrder::UI1) # Bottom
    Gosu.draw_line(@x, @y, TOWER_BOX_BORDER_COLOR, @x, @y + @height, TOWER_BOX_BORDER_COLOR, ZOrder::UI1)              # Left
    Gosu.draw_line(@x + @width, @y, TOWER_BOX_BORDER_COLOR, @x + @width, @y + @height, TOWER_BOX_BORDER_COLOR, ZOrder::UI1) # Right

    # draw tower box background
    Gosu.draw_rect(@x, @y, @width, @height, TOWER_BOX_BG, ZOrder::UI0)

    # draw tower image
    @tower_img.draw(@x, @y-(@tower_img.height/2), ZOrder::UI1)
  end

  def clicked?(mouse_x, mouse_y)
    case @ui_type
      when 'tower_box_button'
        cursor_insde_area(mouse_x, mouse_y)
    end
  end

  def cursor_insde_area(mouse_x, mouse_y)
    if mouse_x > @x && mouse_x < @x + @width && mouse_y > @y && mouse_y < @y + @height
      p 'clicked'
      return true
    else
      return false
    end
  end

end