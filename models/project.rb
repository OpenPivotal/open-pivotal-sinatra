require './models/base'

class Project < Base
  attr_reader :name, :description, :initial_velocity
end