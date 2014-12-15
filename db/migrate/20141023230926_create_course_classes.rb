class CreateCourseClasses < ActiveRecord::Migration
  def change
    create_table :course_classes do |t|
      t.string :name
      t.integer :institution_id
      t.integer :course_id
      t.string :begin
      t.string :end
      t.timestamps
    end
    add_index :course_classes, :name, :unique => true
  end
end
