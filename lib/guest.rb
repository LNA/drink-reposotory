class Guest
  attr_accessor :drinks, :first_name, :guests, :id, 
                :last_name, :orders, :repository

  def initialize(params = {})
    @first_name = params[:first_name]
    @last_name = params[:last_name]
  end

  def update(params = {})
    @first_name = params[:first_name] if params[:first_name]
    @last_name = params[:last_name] if params[:last_name]
  end

  def drinks

    @drinks = []
    
    repository.records.values.first.each do |value|
      if value.guest_id == guest_id
        @drinks << value
      end
    end
    @drinks
  end
end