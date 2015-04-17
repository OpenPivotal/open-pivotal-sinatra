class Base
  def initialize(hash)
    hash.each { |k,v| self.instance_variable_set(:"@#{k}",v) }
  end
end