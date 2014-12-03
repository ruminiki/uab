class CreateUseCases < ActiveRecord::Migration
  def change
    create_table :use_cases do |t|
      t.string :name
      t.string :class_name

      t.timestamps
    end
  end
end
