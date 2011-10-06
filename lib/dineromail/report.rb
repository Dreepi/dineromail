module Dineromail
  class Report
    attr_accessor :transaction_id

    include HappyMapper

    tag 'REPORTE'

    element :report_status, Integer, tag: 'ESTADOREPORTE'

    has_many :operations,   OperationReport

    VALID_REPORT_STATUS = 1
    MALFORMED_REPORT_STATUS = 2
    INVALID_ACCOUNT_NUMBER_REPORT_STATUS = 3
    INVALID_PASSWORD_REPORT_STATUS = 4
    INVALID_REQUEST_TYPE_STATUS = 5
    INVALID_TRANSACTION_ID_REQUEST_STATUS = 6
    INVALID_PASSWORD_OR_ACCOUNT_NUMBER_REQUEST_STATUS = 7
    TRANSACTION_NOT_FOUND_REQUEST_STATUS = 8


    def valid_report?
      report_status == VALID_REPORT_STATUS
    end

  end
end
