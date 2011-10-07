module Dineromail
  class Item
    include HappyMapper

    tag 'ITEM'

    element :description, String,  tag: 'DESCRIPCION'
    element :currency,    Integer, tag: 'MONEDA'
    element :unit_price,  Float,   tag: 'PRECIOUNITARIO'
    element :quantity,    Integer, tag: 'CANTIDAD'

    DOLLAR = 2
    PESO   = 1

  end
end
