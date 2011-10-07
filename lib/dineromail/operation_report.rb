module Dineromail
  class OperationReport

    include HappyMapper

    tag 'OPERACION'

    element :transaction_id, String,  tag: 'ID'
    element :dm_transaction, Integer, tag: 'NUMTRANSACCION'
    element :date,           Dineromail::DateTimeParser, tag: 'FECHA', parser: :parse, on_save: lambda {|d| Dineromail::DateTimeParser.print d }
    element :status,         Integer,  tag: 'ESTADO'
    element :amount,         Float,    tag: 'MONTO'
    element :net_amount,     Float,    tag: 'MONTONETO'
    element :pay_method,     Integer,  tag: 'METODOPAGO'
    element :pay_medium,     String,   tag: 'MEDIOPAGO'
    element :payments,       Integer,  tag: 'CUOTAS'

    has_one  :buyer, Buyer,            tag: 'COMPRADOR'
    has_many :items, Dineromail::Item, tag: 'ITEM'

    PENDING_STATUS   = 1
    COMPLETED_STATUS = 2
    CANCELLED_STATUS = 3

    def pending?
      status == PENDING_STATUS
    end

    def completed?
      status == COMPLETED_STATUS
    end

    def cancelled?
      status == CANCELLED_STATUS
    end

  end
end
