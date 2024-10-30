require 'gosu'
require 'matrix'
require_relative 'constant.rb'

class Enemy
  attr_accessor :obj, :alive, :pos, :max_hp, :speed, :species, :path, :current_hp, :current_frame, :current_direction, :current_animation

  def initialize(species)
    @alive = true
    @species = species
    @path = PATHS.sample.dup # Generating random path
    @pos = Vector.elements(@path.shift) # pos is a 2D vector
    @current_frame = 0
    @current_direction = RIGHT
    @current_animation = WALK
    case @species
      when 'orc'
        @obj = Gosu::Image.load_tiles(ORC_SPRITE+@current_direction+@current_animation+'.png', ORC_SPRITE_WIDTH, ORC_SPRITE_HEIGHT)
        @max_hp = ORC_HP
        @speed = ORC_SPEED
        @current_hp = @max_hp
      when 'slime'
        @obj = Gosu::Image.load_tiles(SLIME_SPRITE+@current_direction+@current_animation+'.png', SLIME_SPRITE_WIDTH, SLIME_SPRITE_HEIGHT)
        @max_hp = SLIME_HP
        @speed = SLIME_SPEED
        @current_hp = @max_hp
      when 'hound'
        @obj = Gosu::Image.load_tiles(HOUND_SPRITE+@current_direction+@current_animation+'.png', HOUND_SPRITE_WIDTH, HOUND_SPRITE_HEIGHT)
        @max_hp = HOUND_HP
        @speed = HOUND_SPEED
        @current_hp = @max_hp
      when 'bee'
        @obj = Gosu::Image.load_tiles(BEE_SPRITE+@current_direction+@current_animation+'.png', BEE_SPRITE_WIDTH, BEE_SPRITE_HEIGHT)
        @max_hp = BEE_HP
        @speed = BEE_SPEED
        @current_hp = @max_hp
    end 
  end

  def update
    if @alive
        self.move
    else 
      self.desotry
    end
  end

  def draw 
    if @alive
      @obj[@current_frame].draw(center_x(@pos[0]), center_y(@pos[1]), ZOrder::CHAR)
      self.diaplay_health_bar
    end
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

    # Change direction and animation if needed
    update_sprites(direction)

    # Update the frame
    update_frame

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

  def update_sprites(direction)
    if update_direction(direction)
      case @species
        when 'orc'
          @obj = Gosu::Image.load_tiles(ORC_SPRITE+@current_direction+@current_animation+'.png', ORC_SPRITE_WIDTH, ORC_SPRITE_HEIGHT)
        when 'slime'
          @obj = Gosu::Image.load_tiles(SLIME_SPRITE+@current_direction+@current_animation+'.png', SLIME_SPRITE_WIDTH, SLIME_SPRITE_HEIGHT)
        when 'hound'
          @obj = Gosu::Image.load_tiles(HOUND_SPRITE+@current_direction+@current_animation+'.png', HOUND_SPRITE_WIDTH, HOUND_SPRITE_HEIGHT)
        when 'bee'
          @obj = Gosu::Image.load_tiles(BEE_SPRITE+@current_direction+@current_animation+'.png', BEE_SPRITE_WIDTH, BEE_SPRITE_HEIGHT)
      end
    end
  end

  def update_direction(direction)
    previous_direction = @current_direction
    angle = Math.atan2(direction[1], direction[0]).to_f
    if angle > -Math::PI/4 && angle <= Math::PI/4
      @current_direction = RIGHT
    elsif angle > Math::PI/4 && angle <= 3*Math::PI/4
      @current_direction = DOWN
    elsif angle > 3*Math::PI/4 || angle <= -3*Math::PI/4
      @current_direction = LEFT
    else
      @current_direction = UP
    end
    return previous_direction != @current_direction
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

  def check_death
    #passed
  end

  # Checking if enemy reach the end of the path
  def check_path_end
    return @path.empty?
  end

  def desotry
    @alive = false if check_path_end
  end

  # Center the enemy sprites
  def center_x(x)
    x - (@obj[current_frame].width / 2)
  end
  def center_y(y)
    y - (@obj[current_frame].height / 2)
  end
end