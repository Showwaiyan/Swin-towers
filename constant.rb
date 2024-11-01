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

# Constant for sprites
# Direction
LEFT = 'L'
RIGHT = 'R'
UP = 'U'
DOWN = 'D'

# Action
WALK = '_Walk'
DEATH = '_Death'

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
