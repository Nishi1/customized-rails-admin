=begin
 Summary: This module is used to handle all breadcrumbs operations for each admin module.
=end
module AdminBreadcrumbs

    def set_breadcrumbs(name,module_name=nil)
		case name
		when "index"
            add_breadcrumb "<i class='fa fa-dashboard'></i>".html_safe+"Dashboard", admin_root_path, :title => "Dashboard"

            add_breadcrumb "Manage #{module_name.present? ? module_name.titlecase.pluralize : controller_name.classify.titlecase.pluralize}", send("admin_#{controller_name}_path"), :title => "Manage #{controller_name.classify.titlecase.pluralize}"
        when "new"
            add_breadcrumb "<i class='fa fa-dashboard'></i>".html_safe+"Dashboard", admin_root_path, :title => "Dashboard"
            add_breadcrumb "Manage #{module_name.present? ? module_name.titlecase.pluralize : controller_name.classify.titlecase.pluralize}", send("admin_#{controller_name}_path"), :title => "Manage #{module_name.present? ? module_name.titlecase.pluralize : controller_name.classify.titlecase.pluralize}"
            add_breadcrumb "Add #{module_name.present? ? module_name : controller_name.classify.titlecase}", send("new_admin_#{controller_name.singularize}_path"), :title => "Add #{module_name.present? ? module_name : controller_name.classify.titlecase}"
		when "edit"
            add_breadcrumb "<i class='fa fa-dashboard'></i>".html_safe+"Dashboard", admin_root_path, :title => "Dashboard"
            add_breadcrumb "Manage #{module_name.present? ? module_name.titlecase.pluralize : controller_name.classify.titlecase.pluralize}", send("admin_#{controller_name}_path"), :title => "Manage #{module_name.present? ? module_name.titlecase.pluralize : controller_name.classify.titlecase.pluralize}"
            add_breadcrumb "Edit #{module_name.present? ? module_name : controller_name.classify.titlecase}", send("edit_admin_#{controller_name.singularize}_path"), :title => "Edit #{module_name.present? ? module_name : controller_name.classify.titlecase}"
        when "view"
            add_breadcrumb "<i class='fa fa-dashboard'></i>".html_safe+"Dashboard", admin_root_path, :title => "Dashboard"
            add_breadcrumb "Manage #{module_name.present? ? module_name.titlecase.pluralize : controller_name.classify.titlecase.pluralize}", send("admin_#{controller_name}_path"), :title => "Manage #{module_name.present? ? module_name.titlecase.pluralize : controller_name.classify.titlecase.pluralize}"
            add_breadcrumb "View #{module_name.present? ? module_name : controller_name.classify.titlecase}", send("admin_message_reply_path"), :title => "Edit #{module_name.present? ? module_name : controller_name.classify.titlecase}"
		else
			add_breadcrumb "<i class='fa fa-dashboard'></i>".html_safe+"Dashboard", admin_root_path, :title => "Dashboard"
		end
    end
end

