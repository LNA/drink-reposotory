class Seed
  def self.drinks
    @drink1 = Drink.new(:booze => "vodka", :mixer => "water", :glass => "rocks",:name => "drink1")
    @drink2 = Drink.new(:booze => "gin", :mixer => "tonic", :glass => "tall",:name => "drink2" )
    @drink3 = Drink.new(:booze => "ryb", :mixer => "sour", :glass => "tall",:name => "drink3")

    [@drink1, @drink2, @drink3].each do |drink|
      Repository.for(:drink).save(drink)
    end
  end
end