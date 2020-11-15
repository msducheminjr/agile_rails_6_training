class SupportMailbox < ApplicationMailbox
  def process
    email_address = mail.from_address.to_s
    recent_order = Order.where(email: email_address).order('created_at desc').first

    SupportRequest.create!(
      email:    email_address,
      subject:  mail.subject,
      body:     mail.body.to_s,
      order:    recent_order
    )
  end
end
