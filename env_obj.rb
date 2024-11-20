require 'gosu'
require 'matrix'
require_relative 'constant'

class EnvObj
  def initialize(stuff,x,y)
    case stuff
      when 'campfire'
        @obj = Gosu::Image.load_tiles(CAMPFIRE_SPRITE, CAMPFIRE_WIDTH, CAMPFIRE_HEIGHT)
        @pos = [x-CAMPFIRE_WIDTH/2,y-CAMPFIRE_HEIGHT]
        @current_frame = 0
      when 'flagbanner'
        @obj = Gosu::Image.load_tiles(BANNERFLAP_SPRITE, BANNERFLAP_WIDTH, BANNERFLAP_HEIGHT)
        @pos = [x-BANNERFLAP_WIDTH/2, y-BANNERFLAP_HEIGHT]
        @current_frame = 0
    end 
  end

  def update
    update_frame
  end

  def update_frame
    @current_frame = (Gosu::milliseconds / FRAME_DELAY) % @obj.size
  end

  def draw
    @obj[@current_frame].draw(@pos[0], @pos[1], ZOrder::OBJECT)
  end
end