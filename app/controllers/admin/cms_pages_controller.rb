=begin
  Namespace: Admin
  Class  : CmspagesController
  Extension: Admin::CmsPagesController
  Summary  : Includes the operations to manage Cms Pages by admin.
=end
class Admin::CmsPagesController < Admin::AdminParentsController
    
    @@model_name = "CmsPage"
    
    # GET /cms_pages
	def index
	  set_breadcrumbs('index')
	  @page_title= "Manage "+@@model_name	
	  @model_data = @@model_name.constantize.paginate(:page => params[:page],:per_page => RECORD_PER_PAGE).search_params(params).order(sort_column + " " + sort_direction)
	end
  
   # GET /cms_pages/new
	def new
		flash[:warning] = I18n.t('model_data.common.permission_error')
		redirect_to send("admin_#{controller_name}_path") and return
	  set_breadcrumbs('new')
	  @page_title= "Add "+@@model_name	 
	  @model_data = @@model_name.constantize.new      
	end
  
   # POST /cms_pages
    def create
			flash[:warning] = I18n.t('model_data.common.permission_error')
			redirect_to send("admin_#{controller_name}_path") and return
      if params.present?	
	      @model_data = @@model_name.constantize.new(model_params)
	      if @model_data.save 	
	  		flash[:notice] =   I18n.t 'model_data.create.success', model_name: @@model_name.singularize
	        redirect_to send("admin_#{controller_name}_path")    
	      else
	        flash[:warning] = I18n.t('model_data.common.error') 
            @page_title= "Add "+@@model_name
	        render "/admin/#{controller_name}/new" and return          
	      end
	  else
	  	flash[:warning] = I18n.t('model_data.common.error')
	  	redirect_to send("admin_#{controller_name}_path")
	  end
    end

    # GET /cms_pages/1/edit
    def edit  
       if params[:id].present?	
       	@page_title= "Edit "+@@model_name
       	set_breadcrumbs('edit')	
       	@model_data = @@model_name.constantize.find(params[:id]) 
       else
       	flash[:warning] = I18n.t('model_data.common.error')
       	redirect_to send("admin_#{controller_name}_path")
       end      
    end
    
    # PATCH/PUT /cms_pages/1
    def update
    	if params.present? && params[:id].present?
	        @model_data = @@model_name.constantize.find(params[:id])
	        if @model_data.update_attributes(model_params)
	          flash[:notice] = I18n.t 'model_data.update.success', model_name: @@model_name.singularize
	          redirect_to send("admin_#{controller_name}_path")
	        else	
	          @page_title= "Edit "+@@model_name        	
	          flash[:warning] = I18n.t('model_data.common.error')   
	          render "/admin/#{controller_name}/edit" and return     
	        end      
    	else
    		flash[:warning] = I18n.t('model_data.common.error')
    		redirect_to send("admin_#{controller_name}_path")
    	end
    end
   
   # DELETE /cms_pages/1
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
	  params.require(:cms_page).permit( :name, :seo_url, :content, :meta_title, :meta_desc, :meta_keyword,:status )
	end	

end
