class UniversitiesDatatable
  delegate :params, :link_to, :number_to_currency, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: University.count,
      iTotalDisplayRecords: universities.total_entries,
      aaData: data
    }
  end

private

  def data
    universities.map do |university|
      [
       
        university.name,
        university.address,
        university.phone,
        university.created_at.strftime("%B %e, %Y"),
       # link_to 'Edit', edit_admin_organization_path(university.id), title: "Edit"
        link_to("Edit", "/admin/universities/#{university.id}/edit")
        
       
      ]
    end
  end

  def universities
    @universities ||= fetch_universities
  end

  def fetch_universities
    universities = University.order("#{sort_column} #{sort_direction}")
    universities = universities.page(page).per_page(per_page)
    if params[:sSearch].present?
      universities = universities.where("name like :search or address like :search", search: "%#{params[:sSearch]}%")
    end
    universities
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[name address phone created_at]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
