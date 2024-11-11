require 'gosu'
require_relative 'constant.rb'

class Font
  def initialize(font,text,visisble=true)
    @font = font[0]
    @x = font[1]
    @y = font[2]
    @img = font[3]
    @color = font[4]
    @font_type = font[5]
    @text = text
    @visisble = visisble
  end

  def update(text)
    #passed
    @text = text
  end

  def draw
    return if not @visisble
    @img.draw(@x, @y, ZOrder::UI1) if not @img.nil?
    width = @img.nil? ? @x : @x+@img.width
    @font.draw_text(@text, width, @y, ZOrder::UI1, 1.0, 1.0, @color)
  end

  def get_font_type
    return @font_type
  end

  def set_visible
    @visisble = true
  end

  def set_invisible
    @visisble = false
  end
end