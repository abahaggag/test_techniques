class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      
      t.string :name
      t.boolean :gender
      t.date :birth_date
      t.references :department
      t.decimal :salary
      
      t.timestamps null: false
    end
    
    add_index :employees, :department_id
  end
end
