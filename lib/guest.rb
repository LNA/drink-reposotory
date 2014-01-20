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
end