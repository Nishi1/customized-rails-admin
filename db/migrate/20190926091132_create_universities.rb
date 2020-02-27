class CreateUniversities < ActiveRecord::Migration[5.2]
  def change
    create_table :universities do |t|
		t.string :name
		t.string :address
		t.string :city, :limit => 50
		t.string :state, :limit => 50
		t.string :billing_address
		t.integer :zip
		t.string :phone, :limit => 15
		t.boolean :status, default: true
		t.timestamps
    end
  end
end
