class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
    	t.string :role
      t.string :location
    	t.text :description
    	t.date :start
    	t.date :end 
      t.string :category

    	t.references :brother
      t.references :company

     	t.timestamps null: false
    end
  end
end
