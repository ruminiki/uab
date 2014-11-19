class AddDiscFileNameToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :disc_file_name, :string
  end
end
