require 'happymapper'
module Dineromail
  class Notification
    include HappyMapper

    tag 'NOTIFICACION'

    has_many :operations, Dineromail::OperationNotification

    def initialize(options = {})
      @options = options.symbolize_keys
    end

    def get_report
      unless status_report
        transactions_ids = self.operations.map(&:transaction_id)
        status_report = Report.get_for(transaction_ids, @options)
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
  end
end
