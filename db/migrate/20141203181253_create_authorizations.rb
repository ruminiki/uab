class CreateAuthorizations < ActiveRecord::Migration
  def change
    create_table :authorizations do |t|
      t.integer :user_id
      t.integer :use_case_id
      t.boolean :add, default: false
      t.boolean :edit, default: false
      t.boolean :view, default: false
      t.boolean :remove, default: false

      t.timestamps
    end
  end
end
