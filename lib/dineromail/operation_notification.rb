module Dineromail
  class OperationNotification
    include HappyMapper

    tag 'OPERACION'

    element :transaction_id, Integer, tag: 'id'
    element :type,           String,  tag: 'tipo'
  end
end
