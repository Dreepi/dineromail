module DineromailHelper
 
  def dineromail_button(item_name, amount, quantity = 1, options = {})
    options.symbolize_keys!

    button_image_url = options.delete(:button_image_url) || Dineromail.configuration.button_image_url

    form_options = options.delete(:form) || {}
    form_options.reverse_merge!(:action => options.delete(:payment_url) || Dineromail.configuration.payment_url)

    content_tag(:form, form_options) do
      ''.html_safe.tap do |html|
        html << dineromail_inputs(item_name, amount, quantity, options)
        html << content_tag(:input, nil, :type => 'image', :src => button_image_url, :border => '0', :name => 'submit', :alt => 'Pagar con Dineromail' )
      end
    end
  end
  
  
  def dineromail_inputs(item_name, amount, quantity, options = {})
    options.symbolize_keys!
    options.reverse_merge!(:merchant => Dineromail.configuration.account_number,
                           :country_id => Dineromail.configuration.country_id,
                           :header_image => Dineromail.configuration.header_image,
                           :seller_name => Dineromail.configuration.seller_name,
                           :ok_url => Dineromail.configuration.ok_url,
                           :pending_url => Dineromail.configuration.pending_url,
                           :error_url => Dineromail.configuration.error_url,
                           :payment_method_available => Dineromail.configuration.payment_method_available,
                           :currency => Dineromail.configuration.currency,
                           :tool => 'button')
    options.reject!{|k, v| v.nil? }

    #name, amount, quantity
    options[:item_name_1] = item_name
    #convert it to integer
    options[:item_ammount_1] = (amount * 100).to_i
    options[:item_quantity_1] = quantity


    String.new.html_safe.tap do |html|
      options.each do |name, value|
        html << content_tag(:input, nil, :type => 'hidden', :name => name, :value => value)
      end
    end
  end

end

