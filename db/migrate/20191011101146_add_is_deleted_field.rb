class AddIsDeletedField < ActiveRecord::Migration[5.2]
  def change
    add_column :admins ,:is_deleted,:boolean,:default => false   
    add_column :universities ,:is_deleted,:boolean,:default => false 
    add_column :cms_pages ,:is_deleted,:boolean,:default => false   
  end
end
