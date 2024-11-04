require 'gosu'
require_relative 'constant.rb'

class UI
  def initialize(button)
    @ui_type = button[0] # string of ui type which indicates to draw the specific page ui elements
    @x = button[1]
    @y = button[2]
    @width = button[3]
    @height = button[4]
    @border_color = button[5]
    @bg = button[6]
    @img = Gosu::Image.new(button[7]) if not button[7].nil?
  end

  def update
    #passed
  end

  def draw
    self.draw_button
  end

  def draw_button
    # draw background
    @bg.draw(@x, @y, ZOrder::UI0)

    # draw image
    @img.draw(@x+(@width/2)-(@img.width/2), @y-(@img.height/2), ZOrder::UI1) if @ui_type == TOWER_CREATE_BTN_UI_TYPE
    @img.draw((@width-@img.width)+@x,(@height-@img.height)/2+@y, ZOrder::UI1) if @ui_type == TOWER_UPGRADE_BTN_UI_TYPE
  end 

  def get_ui_type
    return @ui_type
  end

  def clicked?(mouse_x, mouse_y)
    if mouse_x > @x && mouse_x < @x + @width && mouse_y > @y && mouse_y < @y + @height
      return true
    else
      return false
    end
  end

end