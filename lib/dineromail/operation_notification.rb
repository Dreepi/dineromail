module Dineromail
  class OperationNotification
    include HappyMapper

    tag 'OPERACION'

    element :transaction_id, String,  tag: 'ID'
    element :type,           Integer,  tag: 'TIPO'

  end
end
