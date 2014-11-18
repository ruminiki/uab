class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :name
      t.string :phone_number
      t.string :rg
      t.string :cpf
      t.date :birthday
      t.integer :employee_category_id
      t.integer :city_id
      t.string :address
      t.string :email

      t.timestamps
    end
  end
end
