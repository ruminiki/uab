class CourseClassesEmployess < ActiveRecord::Migration
  def change
  	create_table :course_classes_employees do |t|
      t.integer :course_class_id
      t.integer :employee_id
      t.timestamps
    end
  end
end
