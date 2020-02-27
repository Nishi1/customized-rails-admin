=begin
 Namespace: Admin
 Class  : AdminParentsController
 Extension: ApplicationController
 Summary  : This is the common class that is inherited in each admin controller classes.
=end
class Admin::AdminParentsController < ApplicationController  	
	before_action :authenticate_admin! ,except: [:check_admin_email]
	layout "admin" 
    helper_method :sort_column, :sort_direction
    respond_to :html
    include AdminBreadcrumbs
    include AdminBulkActions
    include AdminSorting	 
 
end
