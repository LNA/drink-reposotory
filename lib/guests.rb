class Guests
  attr_accessor  :guest, :id, :records

  def initialize
    @records = {}
    @id = 1
  end

  def save(guest)
    @records[@id] = guest
    guest.id = @id
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
end