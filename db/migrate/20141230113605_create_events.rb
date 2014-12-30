class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.string :begin
      t.string :end
      t.string :local
      t.text :resume

      t.timestamps
    end
  end
end
