require 'gosu'
require 'matrix'
require_relative 'constant.rb'

class Enemy
  attr_accessor :obj, :pos, :max_hp, :speed, :path, :current_hp, :current_frame, :current_direction, :current_animation

  def initialize(species)
    @path = PATHS.sample # Generating random path
    @pos = Vector.elements(@path.shift) # pos is a 2D vector
    @current_frame = 0
    @current_direction = RIGHT
    @current_animation = WALK
    case species
      when 'orc'
        @obj = Gosu::Image.load_tiles(ORC_SPRITE+@current_direction+@current_animation+'.png', ORC_SPRITE_WIDTH, ORC_SPRITE_HEIGHT)
        @max_hp = ORC_HP
        @speed = ORC_SPEED
        @current_hp = @max_hp
    end 
  end

  def update
    self.move
    self.update_frame
  end

  def draw 
    @obj[@current_frame].draw(center_x(@pos[0]), center_y(@pos[1]), ZOrder::CHAR)
    self.diaplay_health_bar
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

    # Checking if the enemy has reached the target
    if (@pos - target).magnitude < @speed
      @pos = target # set the position to the target because the enemy has reached the target
      @path.shift # remove the previous target from the path
      target = Vector.elements(@path.first) if @path.any? # this check whether the path array is empty
    end
  end

  def update_frame
    @current_frame = (Gosu::milliseconds / FRAME_DELAY) % @obj.size
  end

  def diaplay_health_bar
    hp_bar_pos = [@pos[0]-ORC_SPRITE_WIDTH/2,@pos[1]-ORC_SPRITE_HEIGHT/2+5] # 5 is the offset
    Gosu::draw_rect(hp_bar_pos[0], hp_bar_pos[1], HP_BAR_WIDTH, HP_BAR_HEIGHT, BAR_HP_COLOR)
    Gosu::draw_rect(hp_bar_pos[0], hp_bar_pos[1], calculate_current_hp_bar_width, HP_BAR_HEIGHT, PLAYER_HP_COLOR)
  end

  def calculate_current_hp_bar_width
    return ((@current_hp.to_f/@max_hp.to_f).to_f * HP_BAR_WIDTH.to_f).to_f if @current_hp > 0
    return 0
  end

  # Center the enemy sprites
  def center_x(x)
    x - (@obj[current_frame].width / 2)
  end
  def center_y(y)
    y - (@obj[current_frame].height / 2)
  end
end