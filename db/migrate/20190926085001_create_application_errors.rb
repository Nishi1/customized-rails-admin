class CreateApplicationErrors < ActiveRecord::Migration[5.2]
  def change
    create_table :application_errors do |t|
      t.integer  "user_id"
      t.text   "error"
      t.text   "url"
      t.timestamps
    end
  end
end
