class NotificationMailer < ApplicationMailer
  default from: ENV["GMAIL_USERNAME"]

  def notify_email(email)
    mail(
      to: email,
      subject: "お問い合わせありがとうございます",
      body: "お問い合わせを受け付けました。返信までしばらくお待ちください。"
    )
  end
end
