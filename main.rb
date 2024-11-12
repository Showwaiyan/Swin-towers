require 'gosu'
require 'matrix'
require_relative 'constant.rb'
require_relative 'enemy.rb'
require_relative 'tower.rb'
require_relative 'button.rb'
require_relative 'font.rb'

module ZOrder
  BACKGROUND, OBJECT, TOWER_UP, ENEMY, TOWER_DOWN, ARCHER, UI0, UI1 = *0..7
end

class Game < Gosu::Window
  def initialize
    super(SCREEN_WIDTH, SCREEN_HEIGHT)
    self.caption = 'Swin Towers'
    @bg = Gosu::Image.new('Assets/map/map.png')
    @heart = MAXIMUM_HEART
    @diamond = 50
    setup_game
  end

  def setup_game
    setup_enemies
    setup_towers
    setup_ui
    setup_resources
  end

  def setup_enemies
    @enemies = []
    @last_spawn = Gosu.milliseconds
    @current_wave = 1
    load_wave_file
    @wave_start = false
  end

  def setup_ui
    @current_ui = setup_start_menu_ui
    @current_ui_type = 'start_menu'
  end

  def setup_resources
    @heart = MAXIMUM_HEART
    @diamond = INITIAL_DIAMOND
  end

  def setup_in_game_ui
    in_game_ui = {
      button: [Button.new(TOWER_CREATE_BTN),Button.new(TOWER_UPGRADE_BTN),Button.new(WAVE_START_BTN)],
      text: [Font.new(HEART_FONT, @heart),Font.new(DIAMOND_FONT, @diamond),Font.new(TOWER_BUY_FONT, TOWERS_COST[0]),Font.new(TOWER_UPGRADE_FONT, 0, false)]
    }
    return in_game_ui
  end

  def setup_start_menu_ui
    start_menu_ui ={
      button: [Button.new(START_BTN)],
      text: [Font.new(GAME_INTRO,"Swin Towers")]
    }
    return start_menu_ui
  end

  def load_wave_file
    @wave_file = File.open("#{WAVE_FILE}#{@current_wave}.txt", 'r')
  end

  def setup_towers
    @towers = []
    @is_tower_overlay = false
    @can_create_tower = false
    @overlay_tower = nil
  end

  def button_down(id)
    case id
      when Gosu::KB_ESCAPE then close
      when Gosu::MS_LEFT 
        handle_tower_creation_or_selection 
        handle_ui_clicks
    end
  end

  def handle_tower_creation_or_selection
    if @is_tower_overlay
      @can_create_tower && @diamond >= TOWERS_COST[0] ? create_tower : cancel_tower_overlay
    else
      select_tower if @towers.any? { |tower| tower.is_clicked?(mouse_x, mouse_y) }
    end
    cancel_tower_highlight
  end

  def handle_ui_clicks
    btns = @current_ui[:button]
    btns.each do |btn|
      next unless btn.is_clicked?(mouse_x, mouse_y)

      case btn.get_ui_type
        when 'start_button'
           @current_ui_type = 'in_game'
           btn.set_invisible
           btn.set_not_operate
          @current_ui = setup_in_game_ui
        when 'tower_create_button' then enable_tower_overlay
        when 'tower_upgrade_button' then upgrade_selected_tower
        when 'wave_start_button' then start_wave(btn)
      end
    end
  end

  def enable_tower_overlay
    @is_tower_overlay = !TOWER_CENTER.empty?
  end

  def upgrade_selected_tower
    tower = @towers.find(&:is_highlighted?)
    return unless tower && !tower.is_arrow_exist?
    tower.upgrade    
    reduce_diamond(tower.get_cost)
    tower.remove_highlight
  end

  def start_wave(btn)
    @wave_start = true
    btn.set_not_operate
    btn.set_invisible
  end

  def select_tower
    @towers.each { |tower| tower.remove_highlight }
    selected_tower = @towers.find { |tower| tower.is_clicked?(mouse_x, mouse_y) }
    selected_tower&.set_highlight
  end

  def cancel_tower_overlay
    @is_tower_overlay = false
  end

  def cancel_tower_highlight
    return if @current_ui_type != 'in_game'
    if (not @towers.any? { |tower| tower.is_clicked?(mouse_x, mouse_y) }) && !(@current_ui[:button].find { |btn| btn.get_ui_type == 'tower_upgrade_button' }).is_clicked?(mouse_x, mouse_y)
    # if tower is not selected and upgrade button is no clicked
      @towers.each { |tower| tower.remove_highlight }
    end
  end

  def update
    return if is_game_over?
    case @current_ui_type
      when 'start_menu' then update_start_menu
      when 'in_game' then update_in_game
    end
  end

  def update_start_menu 
    update_ui
  end

  def update_in_game
    spawn_enemy if @wave_start
    update_enemies  
    update_wave if wave_complete?
    @towers.each(&:update)
    assign_targets
    update_ui
  end

  def spawn_enemy
    if (Gosu::milliseconds-@last_spawn > SPAWN_DELAY) && !@wave_file.eof?
      @enemies << Enemy.new(@wave_file.gets.chomp)
      @last_spawn = Gosu::milliseconds
    end
  end

  def update_enemies
    @enemies.compact!
    @enemies.each do |enemy|
      enemy.update
      reduce_heart if enemy.check_path_end?
      increase_diamond(enemy.get_species) if enemy.can_destory?
    end
    @enemies.delete_if { |enemy| enemy.check_path_end? || enemy.can_destory? }
  end

  def wave_complete?
    @wave_file.eof? && @enemies.empty?
  end

  def update_wave
    return if @current_wave >= MAX_WAVE
    @current_wave += 1
    load_wave_file
    reset_wave_start
  end

  def reset_wave_start
    @wave_start = false
    @current_ui[:button].find { |btn| btn.get_ui_type == 'wave_start_button' }.set_operate
  end

  def assign_targets
    @towers.each do |tower|
      next if tower.is_set_target?
      @enemies.each do |enemy|
        tower.get_target(enemy)
        break if tower.is_set_target?
      end  
    end
  end

  def update_ui
    update_button_state
    update_texts
  end

  def update_button_state
    return if @current_ui[:button].nil?
    @current_ui[:button].each do |btn|
      case btn.get_ui_type
        when 'tower_create_button' then update_tower_create_button(btn)
        when 'tower_upgrade_button' then update_tower_upgarde_button(btn)
      end
    end
  end

  def update_tower_create_button(btn)
    btn.set_active if @diamond >= TOWERS_COST[0]
    btn.set_inactive if @diamond < TOWERS_COST[0]
  end

  def update_tower_upgarde_button(btn)
    selected_tower = @towers.find(&:is_highlighted?)
    if !selected_tower || selected_tower.is_max_level? || @diamond < selected_tower.get_upgrade_cost
      btn.set_inactive
      btn.set_not_operate
    else
      btn.set_active
      btn.set_operate
    end
  end

  def update_texts
    return if @current_ui[:text].nil?
    @current_ui[:text].each do |text|
      case text.get_font_type
        when 'heart' then text.update(@heart)
        when 'diamond' then text.update(@diamond)
        when 'tower_upgrade' 
          selected_tower = @towers.find(&:is_highlighted?)
          text.update(selected_tower&.get_upgrade_cost)
          text.set_invisible if !selected_tower || selected_tower.is_max_level?
          text.set_visible if selected_tower && !selected_tower.is_max_level?
      end
    end
  end

  def draw
    draw_background
    case @current_ui_type
      when 'start_menu' then draw_start_menu
      when 'in_game' then draw_in_game
    end
  end

  def draw_start_menu
    Gosu::draw_rect(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, Gosu::Color::rgba(0, 0, 0, 128), ZOrder::UI0)
    draw_ui
  end

  def draw_in_game
    draw_towers
    draw_enemies
    draw_ui
    draw_tower_overlay if @is_tower_overlay 
  end

  def draw_background
    @bg.draw(0, 0, ZOrder::BACKGROUND)
  end

  def draw_towers
    @towers.each(&:draw)
  end

  def draw_enemies
    @enemies.each(&:draw)
  end

  def draw_ui
    @current_ui[:button].each(&:draw) if not @current_ui[:button].nil?
    @current_ui[:text].each(&:draw) if not @current_ui[:text].nil?
  end

  def draw_tower_overlay
    @overlay_tower ||=Tower.new
    @overlay_tower.update_pos(mouse_x, mouse_y)
    color = tower_overlay_color
    @overlay_tower.draw_overlay(@overlay_tower.get_pos_x, @overlay_tower.get_pos_y, color)
  end

  def tower_overlay_color
    is_tower_placeable(mouse_x, mouse_y) && @diamond >= TOWERS_COST[0] ? Gosu::Color.rgba(0, 255, 0, 128) : Gosu::Color.rgba(255, 0, 0, 128)
  end

  def is_tower_placeable(mouse_x, mouse_y)
    TOWER_CENTER.each do |center|
      if cursor_in_area?(center, mouse_x, mouse_y)
        @overlay_tower.update_pos(center[0], center[1])
        @overlay_tower.update_ZOrder(center[0], center[1])
        @can_create_tower = true
        return true
      end
    end
    @can_create_tower = false
    return false
  end

  def cursor_in_area?(center, mouse_x, mouse_y)
    center_x, center_y = center
    left_x, top_y = center_x - TOWER_SPRITE_WIDTH / 2, center_y - TOWER_SPRITE_HEIGHT / 4
    right_x, bottom_y = center_x + TOWER_SPRITE_WIDTH / 2, center_y + TOWER_SPRITE_HEIGHT / 4
    mouse_x.between?(left_x, right_x) && mouse_y.between?(top_y, bottom_y)
  end

  def create_tower
    @towers << @overlay_tower
    TOWER_CENTER.delete([@overlay_tower.get_pos_x, @overlay_tower.get_pos_y])
    @overlay_tower = nil
    reduce_diamond(TOWERS_COST[0])
    cancel_tower_overlay
  end

  def reduce_heart
    @heart -= 1
  end

  def reduce_diamond(amount)
    @diamond -= amount
  end

  def is_game_over?
    @heart <= 0
  end

  def increase_diamond(enemy_type)
    @diamond += case enemy_type
                when 'orc' then ORC_DIAMOND
                when 'slime' then SLIME_DIAMOND
                when 'hound' then HOUND_DIAMOND
                when 'bee' then BEE_DIAMOND
                end 
  end
end

Game.new.show