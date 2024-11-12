require 'gosu'
require_relative 'constant.rb'

class Button
  def initialize(button, active=true, visible=true, operate=true)
    @ui_type = button[0] # string of ui type which indicates to draw the specific page ui elements
    @x = button[1]
    @y = button[2]
    @width = button[3]
    @height = button[4]
    @border_color = button[5]
    @bg = button[6] if not button[6].nil?
    @img = Gosu::Image.new(button[7]) if not button[7].nil?
    @active = active
    @visible =  visible
    @operate = operate # to check whether the button is clickable or not
  end

  def update
    #passed
  end

  def draw
    return if not is_visible?
    self.draw_button
    Gosu.draw_rect(@x, @y, @bg.width, @bg.height, Gosu::Color::rgba(0, 0, 0, 128), ZOrder::UI1) if not @active
  end

  def draw_button
    # draw background
    @bg.draw(@x, @y, ZOrder::UI0) if not @bg.nil?

    # draw image
    @img.draw(@x+@bg.width/2-@img.width/2, @y+@bg.height/2-@img.height/2, ZOrder::UI1) if @ui_type == START_BTN_UI_TYPE
    @img.draw(@x+(@width/2)-(@img.width/2), @y-(@img.height/2), ZOrder::UI1) if @ui_type == TOWER_CREATE_BTN_UI_TYPE
    @img.draw((@width-@img.width)+@x,(@height-@img.height)/2+@y, ZOrder::UI1) if @ui_type == TOWER_UPGRADE_BTN_UI_TYPE
    @img.draw((@width-@img.width)+@x/4,(@height-@img.height)/2+@y, ZOrder::UI1) if @ui_type == WAVE_START_BTN_UI_TYPE
  end 

  def get_ui_type
    return @ui_type
  end

  def set_active 
    @active = true
  end

  def set_inactive
    @active = false
  end
  
  def set_visible
    @visible = true
  end
  
  def set_invisible
    @visible = false
  end

  def is_visible?
    return @visible
  end

  def set_operate
    @operate = true
  end

  def set_not_operate
    @operate = false
  end

  def is_operate?
    return @operate
  end

  def is_clicked?(mouse_x, mouse_y)
    return if not is_operate?
    if mouse_x > @x && mouse_x < @x + @width && mouse_y > @y && mouse_y < @y + @height
      return true
    else
      return false
    end
  end

end