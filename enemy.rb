require 'gosu'

class Enemy
  attr_accessor :name, :hp, :speed, :path
  def generate_random_path
    # passed
    return path
  end

  def initialize(name, hp, speed, path)
    @name = name 
    @hp = hp
    @speed = speed
    @path = path # path would be choosen randomly by give path
  end
end