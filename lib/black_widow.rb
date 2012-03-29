# encoding: utf-8
class BlackWidow
  TARGET = "http://app.zjepb.gov.cn:8080/wasdemo/search?channelid=121215"
  DATA_XPATH = "table tr[4] table tr"
  DATE_XPATH = "div#1"

  LABELS = [
    %w(city   城市名称),
    %w(pm     日平均浓度),
    %w(iaqi   分指数)
  ].freeze

  def initialize
    @agent = Mechanize.new { |a| a.user_agent_alias = "Windows IE 6" }
    @page = @agent.get(TARGET)
  end

  def bite
    col_mapping = {}

    date = get_date
    ts = Time.now

    return if Matter.first(:date => date)

    rows = @page.root.css(DATA_XPATH)
    rows.first.css("td").each_with_index do |col, idx|
      if l = LABELS.detect { |label| col.text.include?(label[1]) }
        col_mapping[l[0]] = idx
      end
    end

    rows[1..-1].each do |row|
      data = row.css("td")
      matter = Matter.new(:date => date, :created_at => ts)

      LABELS.each do |l|
        matter[l[0]] = data[col_mapping[l[0]]].text.strip
      end

      matter.save
    end
  end

  private
  def get_date
    date = @page.root.css(DATE_XPATH).attr("value").text.split("-").collect(&:to_i)
    date.size == 3 ? Date.new(*date) : Date.today.prev_date
  end
end
