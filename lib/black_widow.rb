# encoding: utf-8
class BlackWidow
  TARGET = "http://app.zjepb.gov.cn:8080/wasdemo/search?channelid=121215"
  DATA_XPATH = "table tr[4] table tr"
  DATE_XPATH = "table tr[3] font"

  LABELS = [
    %w(city   城市名称),
    %w(pm     日平均浓度),
    %w(iaqi   分指数)
  ].freeze

  def initialize
    @agent = Mechanize.new { |a| a.user_agent_alias = "Windows IE 6" }
  end

  def bite
    @page = @agent.get(TARGET)
    col_mapping = {}

    date = @page.root.css(DATE_XPATH).text.split(/[年月日]/).collect(&:to_i)
    date = Date.new *date
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
end
