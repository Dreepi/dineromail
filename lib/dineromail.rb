require 'dineromail/version'
require 'dineromail/currency'
require 'dineromail/country'
require 'dineromail/notification'
require 'dineromail/buyer'
require 'dineromail/operation'
require 'dineromail/item'
require 'dineromail/status_report'
require 'dineromail/configuration'
require 'dineromail/app/helpers/dineromail_helper'
require 'action_controller'

module Dineromail
  self.configure do |config|
    #Default confiuration
    config.payment_method_available = 'all' #Todos
    config.ipn_webservice_url = 'https://argentina.dineromail.com/Vender/Consulta_IPN.asp'
    config.payment_url = "https://checkout.dineromail.com/CheckOut"
    config.button_image_url = 'https://argentina.dineromail.com/imagenes/vender/boton/comprar-gris.gif'
  end
end

ActionController::Base.helper(DineromailHelper)
