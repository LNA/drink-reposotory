class Seed
  def self.drinks
    @drink1 = Drink.new(:booze => "vodka", :mixer => "water", :glass => "rocks",:name => "drink1")
    @drink2 = Drink.new(:booze => "gin", :mixer => "tonic", :glass => "tall",:name => "drink2" )
    @drink3 = Drink.new(:booze => "ryb", :mixer => "sour", :glass => "tall",:name => "drink3")

    [@drink1, @drink2, @drink3].each do |drink|
      Repository.for(:drink).save(drink)
    end
  end

  def self.guests
    @guest1 = Guest.new(:first_name => "Tina", :last_name => "Turner")
    @guest2 = Guest.new(:first_name => "Miles", :last_name => "Davis" )
    @guest3 = Guest.new(:first_name => "Oprah", :last_name => "Winfrey")

    [@guest1, @guest2, @guest3].each do |guest|
      Repository.for(:guest).save(guest)
    end
  end
end