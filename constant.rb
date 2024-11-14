require 'gosu'

# Constant for Display
SCREEN_WIDTH = 1024
SCREEN_HEIGHT = 768

FRAME_DELAY = 100
SPAWN_DELAY = 1000 # 1000 milliseconds = 1 second

MAXIMUM_HEART = 5
INITIAL_DIAMOND = 50

HP_BAR_WIDTH = 50
HP_BAR_HEIGHT = 5
BAR_HP_COLOR = Gosu::Color::RED
PLAYER_HP_COLOR = Gosu::Color::GREEN

# Wave File location
WAVE_FILE = 'Waves/wave_'

# Maximum wave
MAX_WAVE = 1

# Maximum level for tower
MAX_TOWER_LEVEL = 7

# Button
# Start Button
START_BTN_UI_TYPE = 'start_button'
START_BTN_IMG = 'Assets/ui/play.png'
START_BTN_WIDTH = 160
START_BTN_HEIGHT = 85
START_BTN_X = SCREEN_WIDTH/2 - START_BTN_WIDTH/2
START_BTN_Y = SCREEN_HEIGHT - START_BTN_HEIGHT*2
START_BORDER_COLOR = Gosu::Color::BLACK
START_BTN_BG = Gosu::Image.new('Assets/ui/rect_bg.png')
START_BTN = [START_BTN_UI_TYPE, START_BTN_X, START_BTN_Y, START_BTN_WIDTH, START_BTN_HEIGHT, START_BORDER_COLOR, START_BTN_BG, START_BTN_IMG]

# Tower Create button 
TOWER_CREATE_BTN_UI_TYPE = 'tower_create_button'
TOWER_CREATE_BTN_IMG = 'Assets/ui/tower.png'
TOEWR_CREATE_BTN_WIDTH = 80
TOWER_CREATE_BTN_HEIGHT = 83
TOWER_CREATE_BTN_X = 29
TOWER_CREATE_BTN_Y = 662
TOWER_CREATE_BORDER_COLOR = Gosu::Color::BLACK
TOWER_CREATE_BTN_BG = Gosu::Image.new('Assets/ui/square_bg.png')
TOWER_CREATE_BTN = [TOWER_CREATE_BTN_UI_TYPE, TOWER_CREATE_BTN_X, TOWER_CREATE_BTN_Y, TOEWR_CREATE_BTN_WIDTH, TOWER_CREATE_BTN_HEIGHT, TOWER_CREATE_BORDER_COLOR, TOWER_CREATE_BTN_BG, TOWER_CREATE_BTN_IMG]

# Tower Upgrade button
TOWER_UPGRADE_BTN_UI_TYPE = 'tower_upgrade_button'
TOWER_UPGRADE_BTN_IMG = 'Assets/ui/upgrade.png'
TOWER_UPGRADE_BTN_WIDTH = 70
TOWER_UPGRADE_BTN_HEIGHT = 70
TOWER_UPGRADE_BTN_X = 129
TOWER_UPGRADE_BTN_Y = 662
TOWER_UPGRADE_BORDER_COLOR = Gosu::Color::BLACK
TOWER_UPGRADE_BTN_BG = Gosu::Image.new('Assets/ui/square_bg.png')
TOWER_UPGRADE_BTN = [TOWER_UPGRADE_BTN_UI_TYPE, TOWER_UPGRADE_BTN_X, TOWER_UPGRADE_BTN_Y, TOWER_UPGRADE_BTN_WIDTH, TOWER_UPGRADE_BTN_HEIGHT, TOWER_UPGRADE_BORDER_COLOR, TOWER_UPGRADE_BTN_BG, TOWER_UPGRADE_BTN_IMG]

# Wave Start button
WAVE_START_BTN_UI_TYPE = 'wave_start_button'
WACE_START_BTN_IMG = 'Assets/ui/start.png'
WAVE_START_BTN_WIDTH = 70
WAVE_START_BTN_HEIGHT = 70
WAVE_START_BTN_X = 17
WAVE_START_BTN_Y = 240
WAVE_START_BORDER_COLOR = Gosu::Color::BLACK
WAVE_START_BTN_BG = Gosu::Image.new('Assets/ui/square_bg.png')
WAVE_START_BTN = [WAVE_START_BTN_UI_TYPE, WAVE_START_BTN_X, WAVE_START_BTN_Y, WAVE_START_BTN_WIDTH, WAVE_START_BTN_HEIGHT, WAVE_START_BORDER_COLOR, WAVE_START_BTN_BG, WACE_START_BTN_IMG]

# Restart Button
RESTART_BTN_UI_TYPE = 'restart_button'
RESTART_BTN_IMG = 'Assets/ui/restart.png'
RESTART_BTN_WIDTH = 70
RESTART_BTN_HEIGHT = 70
RESTART_BTN_X = SCREEN_WIDTH/2 - RESTART_BTN_WIDTH - 25
RESTART_BTN_Y = SCREEN_HEIGHT - RESTART_BTN_HEIGHT*2
RESTART_BORDER_COLOR = Gosu::Color::BLACK
RESTART_BTN_BG = Gosu::Image.new('Assets/ui/square_bg.png')
RESTART_BTN = [RESTART_BTN_UI_TYPE, RESTART_BTN_X, RESTART_BTN_Y, RESTART_BTN_WIDTH, RESTART_BTN_HEIGHT, RESTART_BORDER_COLOR, RESTART_BTN_BG, RESTART_BTN_IMG]

# Exit Button
EXIT_BTN_UI_TYPE = 'exit_button'
EXIT_BTN_IMG = 'Assets/ui/exit.png'
EXIT_BTN_WIDTH = 70
EXIT_BTN_HEIGHT = 70
EXIT_BTN_X = SCREEN_WIDTH/2 + 25
EXIT_BTN_Y = SCREEN_HEIGHT - EXIT_BTN_HEIGHT*2
EXIT_BORDER_COLOR = Gosu::Color::BLACK
EXIT_BTN_BG = Gosu::Image.new('Assets/ui/square_bg.png')
EXIT_BTN = [EXIT_BTN_UI_TYPE, EXIT_BTN_X, EXIT_BTN_Y, EXIT_BTN_WIDTH, EXIT_BTN_HEIGHT, EXIT_BORDER_COLOR, EXIT_BTN_BG, EXIT_BTN_IMG]

# Font
GAME_INTRO_X = SCREEN_WIDTH/2
GAME_INTRO_Y = 300
GAME_INTRO_IMG = nil
GAME_INTRO_COLOR = Gosu::Color::WHITE
GAME_INTRO_TYPE = 'game_intro'
GAME_INTRO_OBJ = Gosu::Font.new(100)
GAME_INTRO = [GAME_INTRO_OBJ,GAME_INTRO_X-GAME_INTRO_OBJ.text_width("Swin Towers")/2, GAME_INTRO_Y, GAME_INTRO_IMG, GAME_INTRO_COLOR,GAME_INTRO_TYPE]

HEART_FONT_X = 896
HEART_FONT_Y = 40
HEART_FONT_IMG = Gosu::Image.new('Assets/map/heart.png')
HEART_FONT_COLOR = Gosu::Color::WHITE
HEART_FONT_TYPE = 'heart'
HEART_FONT_OBJ = Gosu::Font.new(HEART_FONT_IMG.height)
HEART_FONT = [HEART_FONT_OBJ,HEART_FONT_X, HEART_FONT_Y, HEART_FONT_IMG, HEART_FONT_COLOR,HEART_FONT_TYPE]

DIAMOND_FONT_X = 780
DIAMOND_FONT_Y = 40
DIAMOND_FONT_IMG = Gosu::Image.new('Assets/map/diamond.png')
DIAMOND_FONT_COLOR = Gosu::Color::WHITE
DIAMOND_FONT_TYPE = 'diamond'
DIAMOND_FONT_OBJ = Gosu::Font.new(DIAMOND_FONT_IMG.height)
DIAMOND_FONT = [DIAMOND_FONT_OBJ,DIAMOND_FONT_X, DIAMOND_FONT_Y, DIAMOND_FONT_IMG, DIAMOND_FONT_COLOR,DIAMOND_FONT_TYPE]

TOWER_BUY_FONT_X = 29
TOWER_BUY_FONT_Y = 632
TOWER_BUY_FONT_IMG = Gosu::Image.new('Assets/map/small_diamond.png')
TOWER_BUY_FONT_COLOR = Gosu::Color::WHITE
TOWER_BUY_FONT_TYPE = 'tower_buy'
TOWER_BUY_FONT_OBJ = Gosu::Font.new(30)
TOWER_BUY_FONT = [TOWER_BUY_FONT_OBJ,TOWER_BUY_FONT_X, TOWER_BUY_FONT_Y, TOWER_BUY_FONT_IMG, TOWER_BUY_FONT_COLOR,TOWER_BUY_FONT_TYPE]

TOWER_UPGRADE_FONT_X = 129
TOWER_UPGRADE_FONT_Y = 632
TOWER_UPGRADE_FONT_IMG = Gosu::Image.new('Assets/map/small_diamond.png')
TOWER_UPGRADE_FONT_COLOR = Gosu::Color::WHITE
TOWER_UPGRADE_FONT_TYPE = 'tower_upgrade'
TOWER_UPGRADE_FONT_OBJ = Gosu::Font.new(30)
TOWER_UPGRADE_FONT = [TOWER_UPGRADE_FONT_OBJ,TOWER_UPGRADE_FONT_X, TOWER_UPGRADE_FONT_Y, TOWER_UPGRADE_FONT_IMG, TOWER_UPGRADE_FONT_COLOR,TOWER_UPGRADE_FONT_TYPE]

# Tower
TOWER_SPRITE = 'Assets/tower/'
TOWER_SPRITE_WIDTH = 70
TOWER_SPRITE_HEIGHT = 130

ARCHER_SPRITE = 'Assets/archer/'
ARCHER_SPRITE_WIDTH = 48
ARCHER_SPRITE_HEIGHT = 48

ARROW_SPRITE = 'Assets/archer/arrow.png'
ARROW_WIDTH = 14
ARROW_HEIGHT = 3

# Vaue for tower
TOWERS_COST = [10, 20, 30, 40, 50, 60, 70]

# Direction
LEFT = 'L'
RIGHT = 'R'
UP = 'U'
DOWN = 'D'

# Action
WALK = '_Walk'
DEATH = '_Death'
IDEL = '_Idel'
ATTACK = '_Attack'

# Orc
ORC_SPRITE = 'Assets/orc/'
ORC_SPRITE_WIDTH = 48
ORC_SPRITE_HEIGHT = 48
ORC_HP = 20
ORC_SPEED = 0.3
ORC_DIAMOND = 15

# Slime
SLIME_SPRITE = 'Assets/slime/'
SLIME_SPRITE_WIDTH = 48
SLIME_SPRITE_HEIGHT = 48
SLIME_HP = 3
SLIME_SPEED = 0.4
SLIME_DIAMOND = 2

# Hound
HOUND_SPRITE = 'Assets/hound/'
HOUND_SPRITE_WIDTH = 48
HOUND_SPRITE_HEIGHT = 48
HOUND_HP = 10
HOUND_SPEED = 0.8
HOUND_DIAMOND = 20

# Bee
BEE_SPRITE = 'Assets/bee/'
BEE_SPRITE_WIDTH = 48
BEE_SPRITE_HEIGHT = 48
BEE_HP = 8
BEE_SPEED = 0.7
BEE_DIAMOND = 18

# Path for Enemy
PATH1 = [[0, 315], [79, 280], [185, 210], [283, 167], [367, 255], [288, 433], [208, 526], [269, 597], [365, 632], [500, 618], [625, 544], [733, 474], [835, 472], [875, 558], [915, 589], [1024, 630]]
PATH2 = [[0, 252], [156, 266], [229, 217], [374, 204], [314, 348], [285, 486], [221, 534], [341, 644], [523, 617], [674, 507], [814, 443], [889, 572], [1024, 656]]
PATH3 = [[0, 306], [66, 244], [152, 286], [216, 164], [297, 170], [381, 260], [306, 357], [307, 407], [229, 493], [238, 562], [278, 568], [316, 632], [433, 636], [513, 609], [558, 611], [581, 548], [644, 547], [658, 506], [705, 514], [747, 447], [842, 465], [883, 581], [917, 586], [940, 617], [1024, 598]]
PATHS = [PATH1, PATH2, PATH3]

# Center Point for Tower
TOWER_CENTER = [[62, 192],[254, 289],[413, 159],[125, 543],[478, 543],[382, 703],[607, 446],[735, 576],[990, 511]]
