class CreateCourseClassStudents < ActiveRecord::Migration
  def change
    create_table :course_class_students do |t|
      t.integer :student_id
      t.integer :course_class_id
      t.date :date_abandonment
      t.date :date_conclusion
      t.fload :end_not
      t.string :note
      t.timestamps
    end
  end
end
