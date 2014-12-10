class CreateCourseClasses < ActiveRecord::Migration
  def change
    create_table :course_classes do |t|
      t.string :name
      t.integer :institution_id
      t.integer :course_id
      t.string :begin
      t.timestamps
    end
  end
end
