class Drink 
  attr_accessor :booze, :glass, :id, :mixer, :name
  def initialize(params = {})
    @booze = params[:booze]
    @glass = params[:glass]
    @mixer = params[:mixer]
    @name = params[:name]
  end  

  def update(params = {})
  	@booze = params[:booze] unless params[:booze].nil?
    @glass = params[:glass] unless params[:glass].nil?
    @mixer = params[:mixer] unless params[:mixer].nil?
    @name = params[:name]  unless params[:name].nil?
  end
end