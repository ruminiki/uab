class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :name
      t.integer :document_category_id
      t.string :path
      t.string :extension
      t.string :size
      t.string :original_file_name
      t.string :disc_file_name

      t.timestamps
    end
  end
end
