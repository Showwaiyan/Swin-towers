require 'gosu'
require 'matrix'
require_relative 'constant.rb'

class Arrow
  attr_accessor :pos, :speed, :target, :damage
  def initialize(pos, speed, target, damage)
    @pos = Vector.elements(pos)
    @speed = speed
    @target = target
    @damage = damage
    @obj = Gosu::Image.new(ARROW_SPRITE) 
  end

  def update
    self.compute_angle
    self.move
  end

  def compute_angle
    dx = @target.get_pos_x - @pos[0]
    dy = @target.get_pos_y - @pos[1]
    angle = Math.atan2(dy, dx) * 180 / Math::PI
    return angle
  end

  def move
    target_vector = Vector.elements([@target.get_pos_x, @target.get_pos_y])
    direction = (target_vector - @pos).normalize * @speed
    @pos += direction
  end

  def hit?(target)
    target = Vector.elements([target[0], target[1]])
    if (@pos - target).magnitude < @speed
      return true
    else 
      false
    end
  end

  def draw
    @obj.draw_rot(center_x(@pos[0]), center_y(@pos[1]), ZOrder::ARCHER, compute_angle)
  end

  def center_x(x)
    return x - ARROW_WIDTH / 2
  end

  def center_y(y)
    return y - ARROW_HEIGHT / 2
  end
end