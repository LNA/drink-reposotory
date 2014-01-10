class Orders
  attr_accessor :records, :id, :orders, :drink_id,
                :drinks, :guest, :guest_id,
                :increment_guest_id, 
                :check_for_multiple_records
  def initialize
    @records = {}
    @id = 1
  end

  def save(order)
    @records[@id] = order 
    order.id = @id
    @id += 1
  end

  def all
    @records.values
  end

  def find_by_id(id)
    @records[id]
  end

  def delete_by_id(id)
    @records.delete(id)
  end

  def guest_id(order)
    @guest_id = order.guest.records.first.last.id
  end

  def increment_guest_id(order)
    @guest_id = guest_id(order)
    check_for_multiple_records
    @guest_id
  end

  def check_for_multiple_records
    if @records.count >= 2
      @guest_id = @guest_id + 1
    end
  end
end