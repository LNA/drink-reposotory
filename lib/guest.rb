class Guest
  attr_accessor :drinks, :first_name, :guests, :id, 
                :last_name, :orders

  def initialize(params = {})
    @first_name = params[:first_name]
    @last_name = params[:last_name]
  end

  def update(params = {})
    @first_name = params[:first_name] if params[:first_name]
    @last_name = params[:last_name] if params[:last_name]
  end

  def drinks
    guest_orders = Repository.for(:order).all.select { |order| order.guest_id == @id }
    guest_orders.map { |order| Repository.for(:drink).find_by_id(order.drink_id) }
  end
end