class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :name
      t.integer :document_category_id
      t.string :path
      t.string :extension
      t.string :size

      t.timestamps
    end
  end
end
