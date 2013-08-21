class Repository
  attr_accessor :repositories

  def self.register(type, repo)
    repositories[type] = repo
  end

  def self.repositories
    @repositories ||= {}
  end

  def self.for(type) #returns the Drink class
    repositories[type]
  end
end