=begin
 Summary: This is the common class that is inherited in each frontend controller classes
=end
class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  # protect_from_forgery with: :exception
  include ExceptionHandling
  helper_method :encrypt
  before_action :set_mailer_host_with_port
  helper_method :sort_column, :sort_direction
  include AdminSorting
  def set_mailer_host_with_port
    ActionMailer::Base.default_url_options[:host] = request.protocol.to_s + request.host_with_port.to_s
  end

  def after_sign_out_path_for(resource)	 	   
  	 if resource == :admin	
  		  admin_session_path
  	 else
        root_path
     end
  end

 def after_sign_in_path_for(resource)    
    if resource.is_a?(Admin)
        admin_root_path     
      elsif resource.is_a?(User)  
        if resource.user_type_id == COACH_ID  
          groups_path
        else
          users_dashboard_path
        end    
    end
 end


 def not_found
   @namespace = request.path.split('/').second
   if @namespace == "admin"	   
	render layout: "layouts/admin"
   else
    render layout: "layouts/application"
   end
 end
 
 def common_error
   @namespace = request.path.split('/').second
   if @namespace == "admin"	   
	render layout: "layouts/admin"
   else
    render layout: "layouts/application"
   end
 end


end
