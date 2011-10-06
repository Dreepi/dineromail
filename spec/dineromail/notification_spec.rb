require 'spec_helper'

describe Dineromail::Notification do
  describe "parsing notification" do
    let(:notification_xml) {File.read( 'spec/fixtures/notification.xml')}
    let(:notification) {Dineromail::Notification.parse(notification_xml)}

    it {notification.operations.count.should == 2}
    it {notification.operations.first.transaction_id.should == 1889}
    it {notification.operations.last.transaction_id.should == 5547}
  end

  it 'should get automaticaly the status data associated with the notification' do
    HTTParty.stub!(:get).and_return {
      stub :body => File.read( 'spec/fixtures/status_report.xml')
    }
    notification_xml = File.read( 'spec/fixtures/notification.xml')
    notifications = Dineromail::Notification.parse(notification_xml)
    notification = notifications.first
    notification.valid_report?.should be_true
    notification.net_amount.should == 50.3
  end

end
