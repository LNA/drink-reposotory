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
end