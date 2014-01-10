class Order
  attr_accessor :guest, :drink, :id

  def initialize(params = {})
    @guest = params[:guest]
    @drink = params[:drink]
  end  

  def update(params = {})
    @guest = params[:guest] unless params [:guest].nil? 
    @drink = params[:drink] unless params [:drink].nil?    
  end

  def find_or_create_by_id(drink_id, guest_id)
    if drink_id == guest_id
      return order
    else
      Order.new(drink_id, guest_id)
    end
  end
end