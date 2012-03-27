module Helpers
  def aqi_table_rows
    Matter::EPA_TABLE.map do |r|
      %(<tr><td data-aqi="#{r[4]}">#{r[2]}~#{r[3]}: #{r[5]}</td></tr>)
    end
  end
end
