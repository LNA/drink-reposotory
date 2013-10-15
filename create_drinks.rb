class CreateDrinks < ActiveRecord::Migration
  def self.up
    create_table :drinks do |drink|
      drink.string     :booze
      drink.string     :glass
      drink.interger   :id
      drink.string     :mixer
      drink.string     :name

      drink.timestamp
    end
    add_index :drinks
  end

  def self.down
    drop_table :drinks 
  end
end