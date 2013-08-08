class Drink
  attr_accessor :params, :booze, :mixer, :glass
  def initialize(params = {})
    @booze = params[:booze]
    @mixer = params[:mixer]
    @glass = params[:glass]
  end  
end