class AddOriginalFileNameToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :original_file_name, :string
  end
end
