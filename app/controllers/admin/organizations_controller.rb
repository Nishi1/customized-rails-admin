=begin
  Namespace: Admin
  Class  : UniversitiesController
  Extension: Admin::AdminParentsController
  Summary  : Includes the operations to manage universities by admin.
=end
class Admin::OrganizationsController < Admin::AdminParentsController
    @@model_name = "University" 
    
    # GET /organizations
	def index
	  set_breadcrumbs('index')
	  @page_title= "Manage Organizations"
	  @model_data = @@model_name.constantize.paginate(:page => params[:page],:per_page => RECORD_PER_PAGE).search_params(params).order(sort_column + " " + sort_direction)
	end
  
   # GET /organizations/new
	def new
	  set_breadcrumbs('new')
	  @page_title= "Add Organization"
	  @model_data = @@model_name.constantize.new      
	end
  
   # POST /organizations
    def create
      if params.present?	
	      @model_data = @@model_name.constantize.new(model_params)
	      if @model_data.save 	
	  		flash[:notice] =   I18n.t 'model_data.create.success', model_name: @@model_name.singularize
	        redirect_to send("admin_#{controller_name}_path")    
	      else
	        flash[:warning] = I18n.t('model_data.common.error') 
            @page_title= "Add Organization"
	        render "/admin/#{controller_name}/new" and return          
	      end
	  else
	  	flash[:warning] = I18n.t('model_data.common.error')
	  	redirect_to send("admin_#{controller_name}_path")
	  end
    end

    # GET /organizations/1/edit
    def edit  
       if params[:id].present?	
       	@page_title= "Edit Organization"
       	set_breadcrumbs('edit')	
       	@model_data = @@model_name.constantize.find(params[:id]) 
       else
       	flash[:warning] = I18n.t('model_data.common.error')
       	redirect_to send("admin_#{controller_name}_path")
       end      
    end
    
    # PATCH/PUT /organizations/1
    def update
			if params.present? && params[:id].present?
	        @model_data = @@model_name.constantize.find(params[:id])	        
	        if @model_data.update_attributes(model_params)
	          flash[:notice] = I18n.t 'model_data.update.success', model_name: @@model_name.singularize
	          redirect_to send("admin_#{controller_name}_path")
	        else	
	          @page_title= "Edit Organization"
	          flash[:warning] = I18n.t('model_data.common.error')   
	          render "/admin/#{controller_name}/edit" and return     
	        end      
    	else
    		flash[:warning] = I18n.t('model_data.common.error')
    		redirect_to send("admin_#{controller_name}_path")
    	end
    end
   
   # DELETE /organizations/1
	def destroy   
		if params[:id].present?
			@model_data = @@model_name.constantize.find(params[:id])   
			if @model_data.delete   
		 	 flash[:notice] = I18n.t 'model_data.destroy.success', model_name: @@model_name.singularize  
		 	 redirect_to send("admin_#{controller_name}_path")   
			else   
		 	 flash[:error] = I18n.t('model_data.common.error')  
			 redirect_to send("admin_#{controller_name}_path")  
			end   
		else
			flash[:error] = I18n.t('model_data.common.error')  
			redirect_to send("admin_#{controller_name}_path") 
		end
	end


 private    
    #The model_params method returns a copy of the model object, returning only the permitted keys and values and when creating a new record only the permitted attributes are passed into the model.
	def model_params 	 
	  params.require(:university).permit( :name, :phone, :address, :city, :state, :zip, :status, :billing_address )
	end	

end
