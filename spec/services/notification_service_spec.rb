require 'rails_helper'

RSpec.describe NotificationService, type: :service do
  let(:customer_with_phone) { FactoryBot.create(:customer, name: "Test User", email: nil, phone: "09012345678") }
  let(:customer_with_email) { FactoryBot.create(:customer, name: "Test User", phone: nil, email: "test@example.com") }
  let(:customer_with_none)  { FactoryBot.build(:customer, name: "Test User", email: nil, phone: nil) }

  describe 'メールまたはSMSを送信するテスト' do
    it '電話番号がある場合、SMSを送信する' do
      expect(Rails.logger).to receive(:info).with("Notification process started for customer: #{customer_with_phone.id}").ordered
      expect(Rails.logger).to receive(:info).with("Sending SMS to #{customer_with_phone.phone}").ordered
      expect(Rails.logger).to receive(:info).with("Notification process completed for customer: #{customer_with_phone.id}").ordered

      NotificationService.send_notification(customer_with_phone)
    end

    it 'メールアドレスがある場合、メールを送信する' do
      allow(NotificationMailer).to receive_message_chain(:notify_email, :deliver_now)

      expect(Rails.logger).to receive(:info).with("Notification process started for customer: #{customer_with_email.id}").ordered
      expect(Rails.logger).to receive(:info).with("Sending email to #{customer_with_email.email}").ordered
      expect(Rails.logger).to receive(:info).with("Notification process completed for customer: #{customer_with_email.id}").ordered

      NotificationService.send_notification(customer_with_email)
    end

    it '電話番号もメールアドレスもない場合、連絡先情報がないことをログに記録する' do
      expect(Rails.logger).to receive(:info).with("Notification process started for customer: #{customer_with_none.id}").ordered
      expect(Rails.logger).to receive(:info).with("No contact information available for customer: #{customer_with_none.id}").ordered
      expect(Rails.logger).to receive(:info).with("Notification process completed for customer: #{customer_with_none.id}").ordered

      NotificationService.send_notification(customer_with_none)
    end
  end
end
