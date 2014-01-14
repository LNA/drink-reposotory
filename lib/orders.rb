class Orders
  attr_accessor :id, :order, :quantity, :records

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

  def find_order(drink_id, guest_id)
    self.all.detect { |order| (order.drink_id == drink_id) && (order.guest_id == guest_id)}
  end 

  def increase_quantity_by_one(drink_id, guest_id)
    order = find_order(drink_id, guest_id)
    order.quantity += 1
  end

  def decrease_quantity_by_one(drink_id, guest_id)
    order = find_order(drink_id, guest_id)
    order.quantity -= 1
  end
end