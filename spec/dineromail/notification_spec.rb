require 'spec_helper'

describe Dineromail::Notification do
  it 'should load the notifications from the notification xml' do
    notification_xml = File.read( 'spec/fixtures/notification.xml')
    notification = Dineromail::Notification.parse(notification_xml)

    notification.operations.count.should == 2
    notification.operations.first.transaction_id.should == 1889
    notification.operations.last.transaction_id.should == 5547
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
