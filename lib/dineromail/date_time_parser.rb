module Dineromail

  class DateTimeParser
    FORMAT = "%m/%d/%Y %I:%M:%S %p"
    def self.parse(value)
      DateTime.strptime(value, FORMAT)
    end

    def self.print(value)
      value.strftime(FORMAT)
    end
  end

end
