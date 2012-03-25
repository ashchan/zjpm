class Matter
  include DataMapper::Resource

  property :id,           Serial
  property :city,         String
  property :pm,           Integer
  property :iaqi,         Integer
  property :date,         Date
  property :created_at,   DateTime

  class << self
    def latest
      date = Date.today
      data = all(:date => date)
      data = all(:date => date.prev_day) if data.empty?
    end
  end
end

DataMapper::auto_upgrade!
