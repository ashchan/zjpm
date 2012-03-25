class Matter
  include DataMapper::Resource

  property :id,           Serial
  property :city,         String
  property :pm,           Integer
  property :iaqi,         Integer
  property :date,         String
  property :created_at,   DateTime
end

DataMapper::auto_upgrade!
