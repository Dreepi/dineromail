module Dineromail
  class OperationNotification
    include HappyMapper

    tag 'OPERACION'

    element :transaction_id, Integer, tag: 'ID'
    element :type,           String,  tag: 'TIPO'

  end
end
