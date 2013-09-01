class Guest
	attr_accessor :first_name, :last_name

	def initialize(params = {})
		@first_name = params[:first_name]
		@last_name = params[:last_name]
	end

	def update(params = {})
  	@first_name = params[:first_name] unless params[:first_name].nil?
    @last_name = params[:last_name] unless params[:last_name].nil?
  end
end