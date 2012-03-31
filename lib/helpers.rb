module Helpers
  def aqi_table_rows
    Matter::EPA_TABLE.map do |r|
      %(<tr><td data-aqi="#{r[4]}"><span>#{r[2]}~#{r[3]}</span> #{r[5]}</td></tr>)
    end
  end
end
