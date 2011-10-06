require 'happymapper'
module Dineromail
  class OperationNotification
    include HappyMapper

    tag 'operacion'

    element :transaction_id, Integer, :tag => 'id'
    element :type,           String, :tag => 'tipo'
  end
end
