module ApplicationHelper
  #This function is used to print server side validations.
  def show_errors(object, field_name)
    if object.errors.any?
      if !object.errors.messages[field_name].blank?
        if object.errors.messages[field_name][1]
          object.errors.messages[field_name][1]
        else
          object.errors.messages[field_name][0]
        end
      end
    end
  end

  #This function is used to sort the table data .
  def sortable(column, title = nil, search = nil)
    title     ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction, :search => search}, {:class => css_class, :remote => true}
  end

  #This function is used to print server side validations.
  def formate_date date
   
    if date.present?
      return date.strftime("%d %B %Y , %I:%M%p")
    else
      return ""
    end
  end

  def format_date date
    if date.present?
      return date.strftime("%d %B %Y")
    else
      return ""
    end
  end

  #This function is used to get list of all coaches.
  def coaches
    @coaches = User.where(:status=>true,:user_type_id => COACH_ID).pluck('concat(first_name," ",last_name) as full_name', :id)
  end

end

