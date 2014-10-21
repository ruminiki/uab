class AddSiglaToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :acronym, :string
  end
end
