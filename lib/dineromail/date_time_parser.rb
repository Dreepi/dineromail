module Dineromail

  class DateTimeParser
    def self.parse(value)
      DateTime.strptime(value, "%m/%d/%Y %I:%M:%S %p")
    end
  end

end
