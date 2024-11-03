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
    @bg_color = button[6]
    @img = Gosu::Image.new(button[7]) if not button[7].nil?
  end

  def update
    #passed
  end

  def draw
    self.draw_button
  end

  def draw_button
    # draw tower box border (border line)
    Gosu.draw_line(@x, @y, @border_color, @x + @width, @y, @border_color, ZOrder::UI1)               # Top
    Gosu.draw_line(@x, @y + @height, @border_color, @x + @width, @y + @height, @border_color, ZOrder::UI1) # Bottom
    Gosu.draw_line(@x, @y, @border_color, @x, @y + @height, @border_color, ZOrder::UI1)              # Left
    Gosu.draw_line(@x + @width, @y, @border_color, @x + @width, @y + @height, @border_color, ZOrder::UI1) # Right

    # draw background
    Gosu.draw_rect(@x, @y, @width, @height, @bg_color, ZOrder::UI0)

    # draw image
    @img.draw(@x, @y-(@img.height/2), ZOrder::UI1) if not @img.nil? && @img.height >= 130 # indicating that the image is tower
  end

  def get_ui_type
    return @ui_type
  end

  def clicked?(mouse_x, mouse_y)
    if mouse_x > @x && mouse_x < @x + @width && mouse_y > @y && mouse_y < @y + @height
      p 'clicked'
      return true
    else
      return false
    end
  end

end