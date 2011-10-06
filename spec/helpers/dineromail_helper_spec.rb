require 'spec_helper'
require 'rspec/rails'
require 'rspec2-rails-views-matchers'

describe DineromailHelper do
  let(:item_name){ "item name" }
  let(:price){ 9.56 }
  let(:quantity){ 2 }
  describe "#dineromail_button" do
    it 'should create a form with hidden fields' do
      generated_html = helper.dineromail_button(item_name, price, quantity)
      generated_html.should have_tag('form') do
        with_tag "input", :with => { :name => 'item_name_1', :type => 'hidden', :value => item_name }
        with_tag "input", :with => { :name => 'item_ammount_1', :type => 'hidden', :value => (price * 100).to_i }
        with_tag "input", :with => { :name => 'item_quantity_1', :type => 'hidden', :value => quantity }
      end
    end
  end

  describe "#dineromail_inputs" do
    it 'should create hidden fields without a form' do
      generated_html = helper.dineromail_inputs(item_name, price, quantity)
      generated_html.should_not have_tag('form')
      generated_html.should have_tag('input', :with => {:type => 'hidden'})
    end
  end

  describe "form & button options" do

    before(:all) do 
      Dineromail.configure do |config|
        config.payment_method_available = 'all'
        config.account_number = '12345678'
        config.seller_name = 'Company Name'
        config.password = 'your_password'
        config.header_image = 'http://example.com/images/logo.png'
        config.ok_url = 'http://example.com/success'
        config.pending_url = 'http://example.com/pending'
        config.error_url = 'http://example.com/error'
        config.currency = Dineromail::Currency::PESO_AR
        config.country_id = Dineromail::Country::ARGENTINA
        config.ipn_webservice_url = 'https://argentina.dineromail.com/Vender/Consulta_IPN.asp'
        config.payment_url = 'https://argentina.dineromail.com/Shop/Shop_Ingreso.asp'
        config.button_image_url = 'https://argentina.dineromail.com/imagenes/vender/boton/comprar-gris.gif'
      end

    end

    it 'should use default dineromail options' do
      generated_html = helper.dineromail_inputs(item_name, price, quantity)

      [:payment_method_available, :seller_name, :header_image, 
        :ok_url, :pending_url, :error_url, :currency, :country_id].each do |opt|
        generated_html.should have_tag('input', :with => { :type => 'hidden', :name => opt, :value => Dineromail.configuration.send(opt) })
      end
      generated_html.should have_tag('input', :with => { :type => 'hidden', :name => 'merchant', :value => Dineromail.configuration.account_number })
    end

    it 'should allow overwrite default options' do
      options = {
        :seller_name => "New Seller Name", :payment_method_available => 'ar_pagofacil', :header_image => "http://www.example.org/logo2.png",
        :ok_url => "http://www.example.org/ok2", :pending_url => "http://www.example.org/pending2", :error_url => "http://www.example.org/error2",
        :currency => Dineromail::Currency::DOLLAR, :country_id => Dineromail::Country::BRASIL
      }
      generated_html = helper.dineromail_inputs(item_name, price, quantity, options)

      options.each_pair do |name, value|
        generated_html.should have_tag('input', :with => { :type => 'hidden', :name => name, :value => value })
      end
    end

    it 'should allow extra button options' do
      options = {
        :transaction_id => 1234567890, :buyer_name => "Juan", :buyer_lastname => "Perez"
      }
      generated_html = helper.dineromail_inputs(item_name, price, quantity, options)

      options.each_pair do |name, value|
        generated_html.should have_tag('input', :with => { :type => 'hidden', :name => name, :value => value })
      end
    end


    it "should allow form options" do
      options = {
        :form => {
          :class => 'form-class'
        }
      }
      generated_html = helper.dineromail_button(item_name, price, quantity, options)

      generated_html.should have_tag('form', :with => options[:form])
    end

  end
end

