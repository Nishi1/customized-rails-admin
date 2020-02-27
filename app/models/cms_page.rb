class CmsPage < ApplicationRecord
  default_scope { where(is_deleted: false) }

  validates :name,
            presence: {:message => "Please enter name"}
  validates :meta_title,
            presence: {:message => "Please enter meta title"}
  validates :meta_keyword,
            presence: {:message => "Please enter meta keyword"}
  validates :meta_desc,
            presence: {:message => "Please enter meta description"}
  validates :seo_url,
            :length   => {:minimum => 2, :maximum => 50, :message => 'Seo URL must be greater than 2 characters and less than 50 characters'},
            uniqueness: {:message => "Seo URL already exist"},
            presence: {:message => "Please enter seo url"}
  validates :content,
            presence: {:message => "Please enter content"}
  validates :status, :inclusion => {:in => [true, false], :message => "Please select status"}

  def self.search_params(params)
    if(params[:search] != nil && params[:search] !='')
      key = "%#{params[:search].strip}%"
      columns = %w{cms_pages.name cms_pages.created_at}
      aliases = columns
                    .map {|c| "#{c} like :search" }
                    .join(' OR ')
      return where [aliases,{search:key}]
    else
      return where []
    end
  end
end
