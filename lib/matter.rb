#encoding: utf-8
class Matter
  include DataMapper::Resource

  property :id,           Serial
  property :city,         String
  property :pm,           Integer
  property :iaqi,         Integer
  property :date,         String#Date
  property :created_at,   DateTime

  def aqi
    self.class.aqi(pm)
  end

  class << self
    def latest
      all(:date => last.date)
    end

    # return [aqi value, category in en, category in zh]
    def aqi(concentration)
      r = EPA_TABLE.detect { |l| (l[0]..l[1]).include?(concentration) }
      v = (r[3] - r[2]) / (r[1] - r[0]) * (concentration - r[0]) + r[2]
      [v.round, r[4], r[5]]
    end
  end

  # http://en.wikipedia.org/wiki/Air_quality
  EPA_TABLE = [
    [0,     15.4,  0,   50,  "Good",      "优良"],
    [15.5,  35.4,  51,  100, "Moderate",  "中等"],
    [35.5,  65.4,  101, 150, "Unhealthy for Sensitive Groups",  "敏感群体有害"],
    [65.5,  150.4, 151, 200, "Unhealthy",  "不健康"],
    [150.5, 250.4, 201, 300, "Very Unhealthy",  "非常不健康"],
    [250.5, 350.4, 301, 400, "Hazardous",  "有毒害一级"],
    [350.5, 500.4, 401, 500, "Hazardous",  "有毒害二级"]
  ]

end

DataMapper::auto_upgrade!
