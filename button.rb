require 'gosu'
require_relative 'constant.rb'

class UI
  def initialize(button, active=true, operate=true)
    @ui_type = button[0] # string of ui type which indicates to draw the specific page ui elements
    @x = button[1]
    @y = button[2]
    @width = button[3]
    @height = button[4]
    @border_color = button[5]
    @bg = button[6] if not button[6].nil?
    @img = Gosu::Image.new(button[7]) if not button[7].nil?
    @active = active
    @operate = operate # indicate whether the button can be clicked or not and visible or not
  end

  def update
    #passed
  end

  def draw
    return if not @operate
    self.draw_button
    Gosu.draw_rect(@x, @y, @bg.width, @bg.height, Gosu::Color::rgba(0, 0, 0, 128), ZOrder::UI1) if not @active
  end

  def draw_button
    # draw background
    @bg.draw(@x, @y, ZOrder::UI0) if not @bg.nil?

    # draw image
    @img.draw(@x+(@width/2)-(@img.width/2), @y-(@img.height/2), ZOrder::UI1) if @ui_type == TOWER_CREATE_BTN_UI_TYPE
    @img.draw((@width-@img.width)+@x,(@height-@img.height)/2+@y, ZOrder::UI1) if @ui_type == TOWER_UPGRADE_BTN_UI_TYPE
    # @img.draw(@x+(@width/2), @y+(@height/2), ZOrder::UI1) if @ui_type == WAVE_START_BTN_UI_TYPE
    @img.draw((@width-@img.width)+@x/4,(@height-@img.height)/2+@y, ZOrder::UI1) if @ui_type == WAVE_START_BTN_UI_TYPE
  end 

  def get_ui_type
    return @ui_type
  end

  def set_inactive
    @active = false
  end

  def set_active 
    @active = true
  end

  def set_operate(operate)
    @operate = operate
  end

  def clicked?(mouse_x, mouse_y)
    if mouse_x > @x && mouse_x < @x + @width && mouse_y > @y && mouse_y < @y + @height
      return true
    else
      return false
    end
  end

end