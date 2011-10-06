module Dineromail
  class Buyer
    include HappyMapper

    tag 'COMPRADOR'

    element :address,         String, tag: 'DIRECCION'
    element :comment,         String, tag: 'COMENTARIO'
    element :document_number, String, tag: 'NUMERODOC'
    element :document_type,   String, tag: 'TIPODOC'
    element :email,           String, tag: 'EMAIL'
    element :name,            String, tag: 'NOMBRE'
    element :phone,           String, tag: 'TELEFONO'

  end
end
