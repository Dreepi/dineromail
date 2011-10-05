module Dineromail
  class Configuration
    attr_accessor :payment_url, :ipn_webservice_url,
      :account_number, :password, :seller_name,
      :logo_url, :button_image_url,
      :ok_url, :pending_url, :error_url,
      :pay_methods, :currency, :country_id
  end

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield configuration
  end

end
