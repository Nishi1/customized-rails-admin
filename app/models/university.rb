class University < ApplicationRecord
  default_scope { where(is_deleted: false) }

  validates :name,
            :length => { :minimum => 2, :maximum => 50 ,:message => 'Name must be greater than 2 characters and less than 50 characters'},
						uniqueness: {:message => "Name already exist"},
						presence: {:message => "Please enter name" }
  validates :address,
            :length => { :minimum => 2, :maximum => 500 ,:message => 'Address must be greater than 2 characters and less than 500 characters'},
						presence: {:message => "Please enter address" }
	validates :city,
            presence: {:message => "Please enter city" }
	validates :state,
            presence: {:message => "Please enter state" }
	validates :zip,
            presence: {:message => "Please enter zip code" }
  validates :phone,
            :length => { :minimum => 10, :maximum => 10 ,:message => 'Phone number must be 10 digits long.'},
            :presence => {:message => "Please enter phone number" },
            :numericality => {:message => "Phone number must be number" }

  validates :status, :inclusion => {:in => [true, false],:message => "Please select status"}
  

   	def self.search_params(params)
		if(params[:search] != nil && params[:search] !='')
			key = "%#{params[:search].strip}%"
			columns = %w{universities.name universities.phone universities.created_at}
			aliases = columns
			.map {|c| "#{c} like :search" }
			.join(' OR ')
			return where [aliases,{search:key}]
		else
			return where []
		end
	end



end
