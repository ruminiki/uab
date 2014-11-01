class CourseClassesStudents < ActiveRecord::Migration
def change
    create_table :course_classes_students, :id => false do |t|
      t.integer :student_id
      t.integer :course_class_id
    end
  end
end
