class CreateRfps < ActiveRecord::Migration[5.0]
  def change
    create_table :rfps do |t|
	  t.string :no
      t.string :bid_number
      t.integer :project_id	
	  t.string :format
      t.string :title
      t.string :description	
	  t.string :rfptype
      t.string :permits
      t.integer :requested_by_id	
	  t.timestamps :plan_start_date
      t.integer :approver_id	
      t.integer :created_by	
      t.integer :updated_by	
	  t.integer :is_active
	  t.timestamps
    end
  end
end
