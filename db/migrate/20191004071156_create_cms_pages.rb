class CreateCmsPages < ActiveRecord::Migration[5.2]
  def change
    create_table :cms_pages do |t|
      t.string :name
      t.text :content
      t.string :meta_title
      t.string :seo_url
      t.string :meta_desc
      t.string :meta_keyword
      t.boolean :status ,:default=>true
      t.timestamps
    end
  end
end
