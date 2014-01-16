class Orders
  attr_accessor :id, :order, :quantity, :records

  def initialize
    @records = {}
    @id = 1
  end

  def save(order)
    new_order = find_or_created(order)
    new_order.quantity += 1
  end

  def find_or_created(order)
    existing_order = find_order(order.drink_id, order.guest_id)

    unless existing_order
      @records[@id] = order
      order.id = @id
      @id += 1
      existing_order = order
    end

    existing_order
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
    @order = find_order(drink_id, guest_id)
    check_and_decrease_quantity
  end

  def check_and_decrease_quantity
    if @order.quantity > 0
      @order.quantity -= 1
    end
  end

  def delete_order(drink_id, guest_id)
    existing_order = find_order(order.drink_id, order.guest_id)
    delete_by_id(order.id)
  end

  def check_and_delete_by_id
    if @order.quantity == 0
      delete_by_id(@id)
    end
  end
end