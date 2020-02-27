class UserMailer < ApplicationMailer
  def request_feedback(data)
    @data = data
    mail(to: @data[:email], subject: 'Request for feedback to admin')
  end

  def contact_us(data)
    @data = data
    mail(to: @data[:email], subject: @data[:subject])
  end

  def sent_msg_admin(data)
    @data = data
    mail(to: @data[:email], subject: @data[:subject])
  end

  def reply_to_player(data)
    @data = data
    mail(to: @data[:email], subject: "Reply to player")
  end

  def reply_to_admin(data)
    @data = data
    mail(to: @data[:email], subject: "Reply to admin")
  end
end
