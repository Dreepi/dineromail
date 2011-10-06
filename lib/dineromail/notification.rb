require 'happymapper'
module Dineromail
  class Notification
    include HappyMapper

    tag 'notificacion'

    has_many :operations, Dineromail::OperationNotification, deep: true

    def initialize(options = {})
      @options = options.symbolize_keys
    end

    def get_report
      unless status_report
        transactions_ids = self.operations.map(&:transaction_id)
        status_report = Report.get_report_for(transaction_ids, @options)
      end
      status_report
    end

    def valid_report?
      status_report.valid_report?
    end

    def method_missing(symbol, *args)
      unless status_report.operations.empty?
        status_report.operations.first.send(symbol, *args)
      end
    end

    def self.parse(xml)
      #Convert tags to lowercase
      xml = xml.gsub(/<(.*?)[> ]/){|tag| tag.downcase}
      super(xml)
    end

  end
end
