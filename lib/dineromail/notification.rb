module Dineromail
  class Notification
    include HappyMapper

    tag 'NOTIFICACION'

    has_many :operations, Dineromail::OperationNotification

    def report(options = {})
      @report ||= request_transactions( self.operations.map(&:transaction_id) )
    end

    def request_transactions(transaction_ids, options = {})
      ipn_url = options[:ipn_webservice_url] || Dineromail.configuration.ipn_webservice_url
      request_data = xml_request_for(transaction_ids, options)
      response = HTTParty.get ipn_url , :query => {:data => request_data}
      Report.parse response.body
    end

    def self.xml_request_for(transaction_ids, options = {})
      account_number = options[:account_number] || Dineromail.configuration.account_number
      password = options[:password] || Dineromail.configuration.password

      xml_ids = transaction_ids.map{|transaction_id| "<ID>#{transaction_id}</ID>" }.join
      <<-EOF
        <REPORTE>
          <NROCTA>#{account_number}</NROCTA>
          <DETALLE>
          <CONSULTA>
            <CLAVE>#{password}</CLAVE>
            <TIPO>1</TIPO>
            <OPERACIONES>
              #{xml_ids}
            </OPERACIONES>
          </CONSULTA>
          </DETALLE>
        </REPORTE>
      EOF
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
