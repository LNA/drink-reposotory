class Drinks
  attr_accessor :records, :id, :drink

  def initialize
    @records = {}
    @id = 1
  end

  def save(drink)
    @records[@id] = drink
    @id += 1
  end
end
