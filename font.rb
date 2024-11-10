require 'gosu'
require_relative 'constant.rb'

class Font
  def initialize(font,text)
    @font = font[0]
    @x = font[1]
    @y = font[2]
    @img = font[3]
    @color = font[4]
    @font_type = font[5]
    @text = text
  end

  def update(text)
    #passed
    @text = text
  end

  def draw
    @img.draw(@x, @y, ZOrder::UI1)
    @font.draw_text(@text, @x+@img.width, @y, ZOrder::UI1, 1.0, 1.0, @color)
  end

  def get_font_type
    return @font_type
  end
end