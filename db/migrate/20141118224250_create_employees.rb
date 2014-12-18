class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :name
      t.string :phone_number
      t.string :rg
      t.string :cpf
      t.string :birthday
      t.integer :employee_category_id
      t.integer :city_id
      t.string :address
      t.string :email
      t.string :secondary_email
      t.string :pis
      t.string :mobile_phone_number
      t.string :sanguine_type

      t.timestamps
    end
  end
end
