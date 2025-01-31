require "twilio-ruby"

class NotificationService
  def self.send_notification(customer)
    Rails.logger.info "Notification process started for customer: #{customer.id}"

    if customer.phone.present?
      send_sms(format_phone_number(customer.phone))
    elsif customer.email.present?
      send_email(customer.email)
    else
      Rails.logger.info "No contact information available for customer: #{customer.id}"
    end

    Rails.logger.info "Notification process completed for customer: #{customer.id}"
  end

  private

  def self.format_phone_number(phone)
    phone.gsub(/\A0/, "+81") # 090xxxxxx → +8190xxxxxx に変換
  end

  def self.send_sms(phone)
    Rails.logger.info "Sending SMS to #{phone}"

    begin
      client = Twilio::REST::Client.new(ENV["TWILIO_ACCOUNT_SID"], ENV["TWILIO_AUTH_TOKEN"])
      message = client.messages.create(
        from: ENV["TWILIO_PHONE_NUMBER"],
        to: phone,
        body: "お問い合わせありがとうございます。"
      )
      Rails.logger.info "SMS sent successfully: #{message.sid}"
    rescue Twilio::REST::RestError => e
      Rails.logger.error "Failed to send SMS: #{e.message}"
    end
  end

  def self.send_email(email)
    Rails.logger.info "Sending email to #{email}"
    NotificationMailer.notify_email(email).deliver_now
  end
end
