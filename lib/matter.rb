#encoding: utf-8
class Matter
  include DataMapper::Resource

  property :id,           Serial
  property :city,         String
  property :pm,           Integer
  property :iaqi,         Integer
  property :date,         Date
  property :created_at,   DateTime

  def aqi
    self.class.aqi(pm)
  end

  class << self
    def latest
      all(:date => max(:date))
    end

    def aqi(concentration)
      r = EPA_TABLE.detect { |l| (l[0]..l[1]).include?(concentration) }
      v = (r[3] - r[2]) / (r[1] - r[0]) * (concentration - r[0]) + r[2]
      [v.round, r[5], r[6]]
    end
  end

  # http://en.wikipedia.org/wiki/Air_quality
  EPA_TABLE = [
    [0,     15.4,  0,   50,  "Good",      "优良",  "00e400"],
    [15.5,  35.4,  51,  100, "Moderate",  "中等",  "ffff00"],
    [35.5,  65.4,  101, 150, "Unhealthy for Sensitive Groups",  "敏感群体有害",  "ff7e00"],
    #[15.5,  40.4,  51,  100, "Moderate"],
    #[40.5,  65.4,  101, 150, "Unhealthy for Sensitive Groups"],
    [65.5,  150.4, 151, 200, "Unhealthy",  "不健康",  "f00"],
    [150.5, 250.4, 201, 300, "Very Unhealthy",  "非常不健康",  "99004c"],
    [250.5, 350.4, 301, 400, "Hazardous",  "有毒害一级",  "7e0023"],
    [350.5, 500.4, 401, 500, "Hazardous",  "有毒害二级",  "730023"]
  ]

end

DataMapper::auto_upgrade!
