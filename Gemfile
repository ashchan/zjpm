source "https://rubygems.org"

gem "sinatra",      "~>1.3.2"
gem "thin",         "~>1.3.1"
gem "data_mapper",  "~>1.2.0"
gem "mechanize",    "~>2.3"

group :development, :test do
  gem "sqlite3",    "~>1.3.5"
  gem "dm-sqlite-adapter"
  gem "racksh"
end

group :production do
  gem "pg"
  gem "dm-postgres-adapter"
end

