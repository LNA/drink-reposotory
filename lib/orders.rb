class Orders
  attr_accessor :records, :id

  def initialize
    @records = {}
    @id = 1
  end

  def save(order)
    @records[@id] = order 
    order.id = @id
    @id += 1
  end

  def all
    @records.values
  end

  def find_by_id(id)
    @records[id]
  end

  def delete_by_id(id)
    @records.delete(id)
  end

  def check_for_multiple_records
    if @records.count >= 2
      @guest_id = @guest_id + 1
    end
    @guest_id
  end

  def drink_id(order)
    @drink_id = order.drink.records.first.last.id
  end

  # def find_order(drink_id, guest_id)
  #   @found_order = all.map {}
  #   Take all of the orders
  #   find the guest_id and the drink_id. 
  #   Return the records id associated with it.

  # end
  
end