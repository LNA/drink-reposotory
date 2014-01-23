class Guest
  attr_accessor :drinks, :first_name, :guests, :id, 
                :last_name, :orders, :guest_id, :order

  def initialize(params = {})
    @first_name = params[:first_name]
    @last_name = params[:last_name]
  end

  def update(params = {})
    @first_name = params[:first_name] if params[:first_name]
    @last_name = params[:last_name] if params[:last_name]
  end

  def orders
    @orders = Repository.for(:order).all.select { |order| order.guest_id == self.id}

    return_orders_or_empty_array_if_none_exist
  end

  private

  def return_orders_or_empty_array_if_none_exist
    if @orders == nil
      @orders = []
    else
      @orders
    end
    @orders
  end
end