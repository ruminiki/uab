class CreateTableCourseClassesDocuments < ActiveRecord::Migration
  def change
    create_table :course_classes_documents do |t|
      t.integer :document_id
      t.integer :course_class_id
      t.timestamps
    end
  end
end
