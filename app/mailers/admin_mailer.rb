class AdminMailer < ApplicationMailer
   # default from: "singhss2525@gmail.com"
     
    def coach_account_creation(data)
        if data.present?           
            @name = "#{data["first_name"].present? ? data["first_name"] : ""} #{data["last_name"].present? ? data["last_name"] : ''}"
            @data = data            
        end
        mail(:to => data["email"], :subject => 'Your coach account has been created')
    end
    
    def player_account_creation(data)
        if data.present?           
            @name = "#{data["first_name"].present? ? data["first_name"] : ""} #{data["last_name"].present? ? data["last_name"] : ''}"
            @data = data            
        end
        mail(:to => data["email"], :subject => 'Your player account has been created')
    end
    
    def user_notification

        @pending_notifications = Notification.where(:is_sent => 0)
        
        p @pending_notifications
        puts "+++++++++++++++++++++++++"
        @pending_notifications.each do |notification|
            email = User.where(:id => notification.user_id).pluck(:email).first
            send_mail(email,notification)
        end
    end   

    def send_mail(email,notification)
        puts " ======== email ======== "
        p email
        puts " ======== content ====== "
        p notification.content
        @content = notification.content 
        res = mail(:to => email, :subject => notification.subject)
        puts " ========= response ============== "
        p res
        notification.update_column(:is_sent,1)
    end
end
