class Drink 
  attr_accessor :booze, :mixer, :glass, :id, :name
  def initialize(params = {})
    @booze = params[:booze]
    @mixer = params[:mixer]
    @glass = params[:glass]
    @name = params[:name]
  end  

  def update(params = {})
  	@booze = params[:booze] unless params[:booze].nil?
    @mixer = params[:mixer] unless params[:mixer].nil?
    @glass = params[:glass] unless params[:glass].nil?
    @name = params[:name]  unless params[:name].nil?
  end
end