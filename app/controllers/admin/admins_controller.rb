=begin
 Namespace: Admin
 Class  : AdminsController
 Extension: Admin::AdminParentsController
 Summary  : This class is responsible to handle admin common operations
=end
class Admin::AdminsController < Admin::AdminParentsController

#To check remote email existence
  def check_admin_email
    existing_email = params[:admin][:email]
    if Admin.exists?(email: existing_email)
      response = "true"
    else
      response = "false"
    end
    render :js => response
  end

#To check Is data already exist.
  def check_uniqueness
      data        = {"university" => :name, "university_team" => :name, "course" => :title, "group" => :title, "user" => :email ,"cms_page"=>:seo_url, "sport" => :title, "question" => :title}
      modal_name  = ""
      column_name = ""
      column_val  = ""
      data.each do |key, val|
        if params[key].present? && params[key][val].present?
          modal_name  = key
          column_name = val
          column_val  = params[key][val].strip
          break
        end
      end
      if params[:existing_data].present? &&  params[:existing_data].strip == column_val
        response = "true"
      elsif modal_name.classify.constantize.unscoped.exists?(column_name => column_val)
        response = "false"
      else
        response = "true"
      end
      render :js => response

  end

  # This function is used to change admin password.
  def change_password
    set_breadcrumbs("change_password")   
    if request.post? || request.patch?      
      admin = Admin.find(current_admin.id)
      @check = params[:admin][:password] == params[:admin][:password_confirmation] && params[:admin][:password].present? && params[:admin][:password_confirmation].present?
      if admin.present? && admin.valid_password?(params[:admin][:old_password])
        if @check           
          if admin.update_attribute(:password, params[:admin][:password])
            sign_in admin, :bypass => true
            flash[:notice] = I18n.t('change_password.update.success')
            redirect_to admin_root_path
          else
            flash[:error] = I18n.t('common.error') 
          end
        else
          flash[:error] = I18n.t('change_password.failure.password_is_not_match')
        end
      else
        flash[:error] = I18n.t('change_password.failure.invalid_old_password')
      end
    end
  end

#This function used to set breadcrumbs on change password page
  def set_breadcrumbs name
    case name          
      when "change_password"
        add_breadcrumb "Dashboard", admin_root_path, :title => "Dashboard"
        add_breadcrumb "Change Password", admin_change_password_path, :title => "Change Password" 
      else
        add_breadcrumb "Dashboard", admin_root_path, :title => "Dashboard"
       end
  end

end


