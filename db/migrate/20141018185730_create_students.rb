class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :name
      t.string :phone_number
      t.string :email
      t.boolean :has_badge
      t.string :badge_observation
      t.date :birthday
      t.string :address

      t.timestamps
    end
  end
end
