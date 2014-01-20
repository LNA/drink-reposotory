class Orders
  attr_accessor :existing_order, :id, :order, :quantity, :records

  def initialize
    @records = {}
    @id = 1
  end

  def save_new(drink_id, guest_id)
    params = {:drink_id => drink_id, 
              :guest_id => guest_id}
    order = Order.new(params)
    @records[@id] = order
    order.id = @id
    @id += 1
    order.quantity += 1
  end

  def find_order(drink_id, guest_id)
    all.detect { |order| (order.drink_id == drink_id) && (order.guest_id == guest_id)}
  end 

  def increase_quantity_by_one(drink_id, guest_id)
    order = find_order(drink_id, guest_id)
    order.quantity += 1
  end

  def delete_order(drink_id, guest_id)
    @existing_order = find_order(drink_id, guest_id)
    reduce_quantity
  end

  def all
    @records.values
  end

  def find_drinks_for_guest_id(guest_id)
    guest_orders = Repository.for(:order).all.select { |order| order.guest_id == guest_id }
    guest_orders.map { |order| Repository.for(:drink).find_by_id(order.drink_id) }
  end

  private
  def reduce_quantity
    if @existing_order.quantity == 1
      @records.delete(existing_order.id)
    else
      @existing_order.quantity -= 1
    end
  end

end