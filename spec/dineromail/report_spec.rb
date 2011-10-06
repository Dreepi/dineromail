require 'spec_helper'
require 'rspec/rails'
require 'rspec2-rails-views-matchers'

describe Dineromail::Report do
  it 'should load the status report from xml' do
    xml = File.read( 'spec/fixtures/report.xml')

    report = Dineromail::Report.parse(xml)
    operation = report.operations.first
    buyer = operation.buyer
    item = operation.items.first

    report.report_status.should == 1
    report.valid_report?.should be_true
    operation.transaction_id.should == 1889
    operation.date.should == DateTime.ordinal(2011,28,12,2,1)
    operation.status.should == Dineromail::Operation::PENDING_STATUS
    operation.pending?.should be_true
    operation.completed?.should be_false
    operation.cancelled?.should be_false
    operation.amount.should == 60.2
    operation.net_amount.should == 50.3
    operation.pay_method.should == 1
    operation.pay_medium.should == 'VISA'
    buyer.email.should == 'comprador@email.com'
    buyer.address.should == 'San Martin 10'
    buyer.comment.should == 'comentario'
    buyer.name.should == 'Juan'
    buyer.phone.should == '4444444'
    buyer.document_type.should == 'DNI'
    buyer.document_number.should == '222222222'
    item.description.should == 'Libro'
    item.currency.should == Dineromail::Currency::PESO_AR
    item.count.should == 2
    item.unit_price.should == 6.9
  end

  describe "xml request options" do

    let(:transaction_ids){ [42] }
    before do
      Dineromail.configure do |c|
        c.account_number = '10000'
        c.password = 'password-123'
      end
    end

    it 'should use the configuration to get the parameters for the request if no options are given' do
      xml_request = Dineromail::Report.xml_request_for(transaction_ids)
      xml_request.should have_tag('nrocta', :text => '10000')
      xml_request.should have_tag('clave', :text => 'password-123')
      xml_request.should have_tag('id', :text => '42')
    end

    it 'should use the option parameters for the request if options are given' do
      xml_request = Dineromail::Report.xml_request_for(transaction_ids, {:account_number => '2000',:password => 'password-456'})
      xml_request.should have_tag('nrocta', :text => '2000')
      xml_request.should have_tag('clave', :text => 'password-456')
      xml_request.should have_tag('id', :text => '42')
    end

  end

end
