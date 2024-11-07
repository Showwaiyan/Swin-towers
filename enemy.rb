require 'gosu'
require 'matrix'
require_relative 'constant.rb'

class Enemy
  def initialize(species)
    @destory = false # destory the whole object from game
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
    unless is_death?
      self.move
    else 
      self.desotry_enemy
    end
  end

  def draw 
    @obj[@current_frame].draw(center_x(@pos[0]), center_y(@pos[1]), ZOrder::ENEMY)
    self.diaplay_health_bar if !is_death?
  end

  def move
    return if check_path_end? # instant return if the path array is empty
    # Calculate the direction to the next target
    target = Vector.elements(@path.first)
    direction = target - @pos
    # normalize the direction
    direction = direction.normalize * @speed
    # move the enemy
    @pos += direction

    # Change direction and animation if needed
    update_sprites if update_direction(direction)

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
    @current_frame = @obj.size - 1 - (Gosu.milliseconds / FRAME_DELAY) % @obj.size if is_death? && @current_direction == RIGHT
    @current_frame = (Gosu::milliseconds / FRAME_DELAY) % @obj.size
  end

  def update_sprites
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
    hp_bar_pos = [@pos[0]-ORC_SPRITE_WIDTH/2,@pos[1]-ORC_SPRITE_HEIGHT/2+10] # 10 is the offset
    Gosu::draw_rect(hp_bar_pos[0], hp_bar_pos[1], HP_BAR_WIDTH, HP_BAR_HEIGHT, BAR_HP_COLOR, ZOrder::ENEMY)
    Gosu::draw_rect(hp_bar_pos[0], hp_bar_pos[1], calculate_current_hp_bar_width, HP_BAR_HEIGHT, PLAYER_HP_COLOR, ZOrder::ENEMY)
  end

  def calculate_current_hp_bar_width
    return ((@current_hp.to_f/@max_hp.to_f).to_f * HP_BAR_WIDTH.to_f).to_f if @current_hp > 0
    return 0
  end

  def hit(damage)
    @current_hp -= damage
  end

  # Checking death
  def is_death?
    return @current_hp <= 0
  end

  # Checking if enemy reach the end of the path
  def check_path_end?
    return @path.empty?
  end

  def desotry_enemy
    if @current_animation != DEATH
      @current_animation = DEATH
      @current_frame = 0 if @current_direction != RIGHT
      @current_frame = @obj.size-1 if @current_direction == RIGHT # due to right death animation is in reverse
      update_sprites
    end
    update_frame
    if (@current_frame == 0 && @current_direction == RIGHT) || (@current_frame == @obj.size-1 && @current_direction != RIGHT)
      # to check if the death animation is finished
      @destory = true
    end
  end

  # Checking if enemy can be destory
  def can_destory?
    return @destory
  end

  def get_pos_x
    return @pos[0]
  end 

  def get_pos_y
    return @pos[1]
  end

  # Center the enemy sprites
  def center_x(x)
    x - (@obj[@current_frame].width / 2)
  end
  def center_y(y)
    y - (@obj[@current_frame].height / 2)
  end
end