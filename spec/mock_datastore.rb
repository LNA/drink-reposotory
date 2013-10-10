class MockDatastore
  attr_accessor :item

  def find_by_id(id)
    @item
  end

  def save(item)
  	@item = item
  end
end