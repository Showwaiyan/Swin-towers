require 'gosu'

# Constant for Display
SCREEN_WIDTH = 1024
SCREEN_HEIGHT = 768

FRAME_DELAY = 100
SPAWN_DELAY = 1000 # 1000 milliseconds = 1 second

HP_BAR_WIDTH = 50
HP_BAR_HEIGHT = 5
BAR_HP_COLOR = Gosu::Color::RED
PLAYER_HP_COLOR = Gosu::Color::GREEN

# Wave File location
WAVE_FILE = 'Waves/wave_'

# Maximum level for tower
MAX_TOWER_LEVEL = 7

# UI
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

# Constant for sprites
# Tower
TOWER_SPRITE = 'Assets/tower/'
TOWER_SPRITE_WIDTH = 70
TOWER_SPRITE_HEIGHT = 130

ARCHER_SPRITE = 'Assets/archer/'
ARCHER_SPRITE_WIDTH = 48
ARCHER_SPRITE_HEIGHT = 48

# Direction
LEFT = 'L'
RIGHT = 'R'
UP = 'U'
DOWN = 'D'

# Action
WALK = '_Walk'
DEATH = '_Death'
IDEL = '_Idel'

# Orc
ORC_SPRITE = 'Assets/orc/'
ORC_SPRITE_WIDTH = 48
ORC_SPRITE_HEIGHT = 48
ORC_HP = 20
ORC_SPEED = 0.5

# Slime
SLIME_SPRITE = 'Assets/slime/'
SLIME_SPRITE_WIDTH = 48
SLIME_SPRITE_HEIGHT = 48
SLIME_HP = 3
SLIME_SPEED = 0.8

# Hound
HOUND_SPRITE = 'Assets/hound/'
HOUND_SPRITE_WIDTH = 48
HOUND_SPRITE_HEIGHT = 48
HOUND_HP = 10
HOUND_SPEED = 1

# Bee
BEE_SPRITE = 'Assets/bee/'
BEE_SPRITE_WIDTH = 48
BEE_SPRITE_HEIGHT = 48
BEE_HP = 8
BEE_SPEED = 1

# Path for Enemy
PATH1 = [[0, 315], [79, 280], [185, 210], [283, 167], [367, 255], [288, 433], [208, 526], [269, 597], [365, 632], [500, 618], [625, 544], [733, 474], [835, 472], [875, 558], [915, 589], [1024, 630]]
PATH2 = [[0, 252], [156, 266], [229, 217], [374, 204], [314, 348], [285, 486], [221, 534], [341, 644], [523, 617], [674, 507], [814, 443], [889, 572], [1024, 656]]
PATH3 = [[0, 306], [66, 244], [152, 286], [216, 164], [297, 170], [381, 260], [306, 357], [307, 407], [229, 493], [238, 562], [278, 568], [316, 632], [433, 636], [513, 609], [558, 611], [581, 548], [644, 547], [658, 506], [705, 514], [747, 447], [842, 465], [883, 581], [917, 586], [940, 617], [1024, 598]]
PATHS = [PATH1, PATH2, PATH3]

# Center Point for Tower
TOWER_CENTER = [[62, 192],[254, 289],[413, 159],[125, 543],[478, 543],[382, 703],[607, 446],[735, 576],[990, 511]]
