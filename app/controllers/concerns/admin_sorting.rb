=begin
 Summary: This module is used to handle sorting operations for each admin module.
=end
module AdminSorting  
  def sort_column
    params[:sort].present? ? params[:sort] : "created_at"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end

end
