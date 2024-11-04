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
    # draw_thick_line(@x, @y, @x + @width, @y, @border_color, 5)
    # draw_thick_line(@x, @y + @height, @x + @width, @y + @height, @border_color, 5)
    # draw_thick_line(@x, @y, @x, @y + @height, @border_color, 5)
    # draw_thick_line(@x + @width, @y, @x + @width, @y + @height, @border_color, 5)

    # draw background
    @bg.draw(@x, @y, ZOrder::UI0)
    # Gosu.draw_rect(@x, @y, @width, @height, @bg_color, ZOrder::UI0)

    # draw image
    @img.draw(@x+(@width/2)-(@img.width/2), @y-(@img.height/2), ZOrder::UI1) if not @img.nil? && @img.height >= 130 # indicating that the image is tower
  end

  def draw_thick_line(x1, y1, x2, y2, color, width)
    angle = Math.atan2(y2 - y1, x2 - x1)
    offset_x = Math.sin(angle) * width / 2
    offset_y = Math.cos(angle) * width / 2
  
    # Draw two lines slightly offset to each side
    Gosu.draw_quad(
      x1 - offset_x, y1 + offset_y, color,
      x1 + offset_x, y1 - offset_y, color,
      x2 + offset_x, y2 - offset_y, color,
      x2 - offset_x, y2 + offset_y, color,
      ZOrder::UI1
    )
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