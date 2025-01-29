class NotificationMailer < ApplicationMailer
  def notify_email(email)
    Rails.logger.info "Sending email to #{email}"
    mail(to: email,
    subject: "お問い合わせありがとうございます",
    body: "お問い合わせを受け付けました。近日中にご連絡いたします。"
    )
  end
end
