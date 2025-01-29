class NotificationService
  def self.send_notification(customer)
    Rails.logger.info "Notification process started for customer: #{customer.id}"

    if customer.phone.present?
      send_sms(customer.phone)
    elsif customer.email.present?
      send_email(customer.email)
    else
      Rails.logger.info "No contact information available for customer: #{customer.id}"
    end

    Rails.logger.info "Notification process completed for customer: #{customer.id}"
  end

  private

  def self.send_sms(phone)
    Rails.logger.info "Sending SMS to #{phone}"
    # 実際のSMS送信処理をここに記述
  end

  def self.send_email(email)
    Rails.logger.info "Sending email to #{email}"
    NotificationMailer.notify_email(email).deliver_now
  end
end
