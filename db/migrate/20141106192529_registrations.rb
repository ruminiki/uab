class Registrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.integer :student_id
      t.integer :course_class_id
      t.integer :registration_status_id
      t.string :date_abandonment
      t.string :date_conclusion
      t.float :end_note
      t.string :note
      t.timestamps
    end
  end
end
