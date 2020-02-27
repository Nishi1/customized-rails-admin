class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'
  def error_notify(admin_email,id,error,url)
    @id = id
    @error = error
    @url = url
    mail(to: admin_email,
         subject: 'Some exception occur')
  end
end
