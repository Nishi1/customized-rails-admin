=begin
  Summary: This module is used to handle all bulk action operations for each admin module.
=end

module AdminBulkActions
  def perform_bulk_action
    redirect_path=params[:controller_name]
    params[:controller_name] = "User" if params[:controller_name] == "players" || params[:controller_name] == "coaches"
    params[:controller_name] = "University" if params[:controller_name] == "organizations"
    params[:controller_name] = "UniversityTeam" if params[:controller_name] == "teams"
    if params.present? && params[:bulk_action].present? && params[:ids].present? && params[:controller_name].present?
      data = params[:controller_name].classify.constantize.where(id: params[:ids])
      if params[:bulk_action] == "active"
        #update_count  = params[:controller_name].classify.constantize.where(id: params[:ids]).update(status: true)
        data.each { |record| record.update_attribute( :status, true ) }
        flash[:notice] = I18n.t('bulk_actions.active')
      elsif params[:bulk_action] == "inactive"
        #update_count   = params[:controller_name].classify.constantize.where(id: params[:ids]).update(status: false)
        data.each { |record| record.update_attribute( :status, false ) }
        flash[:notice] = I18n.t('bulk_actions.inactive')
      elsif params[:bulk_action] == "delete" 
         # params[:controller_name].classify.constantize.where(id: params[:ids]).update(:is_deleted=>true)          
         #Instead of using update_all we have to use loop here because we do not need model validation while deleting any object.
         #
         data.each { |record| record.update_attribute( :is_deleted, true ) }
         flash[:notice] = I18n.t('bulk_actions.destroy')
      end
    else
      flash[:error] = I18n.t('common.error')
    end
    redirect_to send("admin_#{redirect_path}_path")
  end


  # This is the common function that is used to delete particular record from all of the listing pages
  def delete_record
    if request.xhr?
      message = params[:model_name]
      params[:model_name] = "User" if params[:model_name] == "Player" || params[:model_name] == "Coach"
      params[:model_name] = "University" if params[:model_name] == "Organization"
      params[:model_name] = "UniversityTeam" if params[:model_name] == "Team"
      params[:model_name] = "UserCourseResult" if params[:model_name] == "Report"
      params[:model_name] = "UserCourseResult" if params[:model_name] == "RequestedReport"
      response       = {'status' => false, 'message' => I18n.t('common.error')}
      flash[:notice] = I18n.t('common.error')
      if params.present? && params[:model_id].present? && params[:model_name].present?
        if params[:model_name] == "UserCourseResult"
          params[:model_name].constantize.find(params[:model_id]).destroy
          flash[:notice] = I18n.t 'common.destroy', model_name: message.titlecase
        else  
          if params[:model_name].constantize.find(params[:model_id]).update_attribute('is_deleted',true)
            flash[:notice] = I18n.t 'common.destroy', model_name: message.titlecase
            response       = {'status' => true, 'message' => I18n.t('common.destroy')}
          end
        end
      end
      render :json => response
    else
      redirect_to root_url
    end
  end

end



