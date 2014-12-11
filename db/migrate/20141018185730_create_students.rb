class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :name
      t.string :phone_number
      t.string :email
      t.boolean :has_badge
      t.string :badge_observation
      t.string :birthday
      t.string :address
      t.integer :city_id
      t.string :rg
      t.string :cpf
      t.string :sanguine_type
      t.string :badge_end_date
      t.string :badge_number

      t.timestamps
    end
  end
end
