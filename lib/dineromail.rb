require 'action_controller'
require 'dineromail/app/helpers/dineromail_helper'
require 'happymapper'
require 'httparty'

module Dineromail
  autoload :Currency,              'dineromail/currency'
  autoload :Country,               'dineromail/country'
  autoload :Notification,          'dineromail/notification'
  autoload :Buyer,                 'dineromail/buyer'
  autoload :OperationNotification, 'dineromail/operation_notification'
  autoload :OperationReport,       'dineromail/operation_report'
  autoload :Item,                  'dineromail/item'
  autoload :StatusReport,          'dineromail/status_report'

  class Configuration
    attr_accessor :payment_url, :ipn_webservice_url,
      :account_number, :password, :seller_name,
      :header_image, :button_image_url,
      :ok_url, :pending_url, :error_url,
      :payment_method_available, :currency, :country_id
  end

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield configuration
  end


  self.configure do |config|
    #Default configuration
    config.payment_method_available = 'all' #Todos
    config.ipn_webservice_url       = 'https://argentina.dineromail.com/Vender/Consulta_IPN.asp'
    config.payment_url              = "https://checkout.dineromail.com/CheckOut"
    config.button_image_url         = 'https://argentina.dineromail.com/imagenes/vender/boton/comprar-gris.gif'
  end

  ActionController::Base.helper(DineromailHelper)
end

