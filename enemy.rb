require 'gosu'
require 'matrix'
require_relative 'constant.rb'

class Enemy
  attr_accessor :obj, :pos, :hp, :speed, :path, :current_frame

  def initialize(obj, hp, speed)
    @obj = obj
    @hp = hp
    @speed = speed
    @path = PATHS.sample # Generating random path
    @pos = Vector.elements(@path.shift) # pos is a 2D vector
    @current_frame = 0
  end

  def move
    return if @path.empty? # return if the path array is empty
    # Calculate the direction to the next target
    target = Vector.elements(@path.first)
    direction = target - @pos
    # normalize the direction
    direction = direction.normalize * @speed
    # move the enemy
    @pos += direction

    # draw the enemy
    @obj[@current_frame].draw(center_x(@pos[0]), center_y(@pos[1]), ZOrder::CHAR)

    # Checking if the enemy has reached the target
    if (@pos - target).magnitude < @speed
      @pos = target # set the position to the target because the enemy has reached the target
      @path.shift # remove the previous target from the path
      target = Vector.elements(@path.first) if @path.any? # this check whether the path array is empty
    end
  end

  # Center the enemy image
  def center_x(x)
    x - (@obj[current_frame].width / 2)
  end
  def center_y(y)
    y - (@obj[current_frame].height / 2)
  end
end