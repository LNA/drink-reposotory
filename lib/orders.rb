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

  def find_order(drink_id, guest_id)
    self.all.detect { |order| (order.drink_id == drink_id) && (order.guest_id == guest_id)}
  end 

  def increase_quantity_by_one(order_id)
    @records[order_id].quantity += 1
  end

  def decrease_quantity_by_one(order_id)
    @records[order_id].quantity -= 1
  end

  def count_guest_orders(guest_id)
    orders = self.all.find_all { |order| order.guest.id == guest_id }
    orders.count
  end
end