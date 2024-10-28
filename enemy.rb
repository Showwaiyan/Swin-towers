require 'gosu'

class Enemy
  attr_accessor :species, :hp, :speed, :path
  def generate_random_path
    # passed
    return path
  end

  def initialize(species, hp, speed, path)
    @species = species
    @hp = hp
    @speed = speed
    @path = path # path would be choosen randomly by give path
  end
end