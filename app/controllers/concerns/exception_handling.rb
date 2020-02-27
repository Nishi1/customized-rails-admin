#This is common module that is used to handle application all kind of exceptions.
module ExceptionHandling

  # self.included is the hook which automatically runs when this module is included
  def self.included(clazz)
    clazz.class_eval do
      rescue_from ArgumentError, :with => :handle_exceptions
      rescue_from NameError, :with => :handle_exceptions
      rescue_from NoMethodError, :with => :handle_exceptions
      rescue_from ActiveRecord::Rollback, :with => :handle_exceptions
      rescue_from ActiveRecord::StatementInvalid, :with => :handle_exceptions
      rescue_from ActiveRecord::RecordNotFound, :with => :handle_exceptions
      rescue_from ActiveRecord::StaleObjectError, :with => :handle_exceptions
      rescue_from ActiveRecord::RecordInvalid, :with => :handle_exceptions
      rescue_from ActiveRecord::RecordNotSaved, :with => :handle_exceptions
      rescue_from ActionController::MethodNotAllowed, :with => :handle_exceptions
      rescue_from ActionController::InvalidAuthenticityToken, :with => :handle_exceptions
      rescue_from AbstractController::ActionNotFound, with: :handle_exceptions
    end
  end

  # This method is used to save exception and send email to each admin user.
  def save_exception(error)
    app_error  = ApplicationError.new
    user_email = ''
    if request.path.include?('admin') && current_admin.present?
      user = current_admin
    elsif defined?(current_user) && current_user.present?
      user = current_user
    end
    user_email        = user.email if user.present?
    app_error.user_id = user.id if user.present?
    app_error.error   = error.to_s + "#{ error.backtrace[0] if error.backtrace[0].present?}"
    app_error.url     = request.url
    if app_error.save
      ApplicationMailer.error_notify(ADMIN_EMAIL, user_email, app_error.error, app_error.url).deliver_later
    end
  end

  private
  def handle_exceptions(exception)
	   save_exception(exception)     
	   @namespace = request.path.split('/').second
	   if @namespace == "admin"	   
			layout =  "layouts/admin"
	   else
			layout = "layouts/application"
	   end	
	    
	   render "application/common_error", layout: layout and return
  end

end
