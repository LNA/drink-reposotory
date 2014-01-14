class Order
  attr_accessor :drink_id, :guest_id, :id, :quantity

  def initialize(params = {})
    @guest_id = params[:guest_id].to_i
    @drink_id = params[:drink_id].to_i
    @quantity = params[:quantity].to_i
  end  

  def update(params = {})
    @guest_id = params[:guest_id] unless params [:guest_id].nil? 
    @drink_id = params[:drink_id] unless params [:drink_id].nil?  
    @quantity = params[:quantity] unless params [:quantity].nil?  
  end
end