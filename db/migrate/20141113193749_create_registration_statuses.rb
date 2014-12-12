class CreateRegistrationStatuses < ActiveRecord::Migration
  def change
    create_table :registration_statuses do |t|
      t.string :name
      t.boolean :show_list_of_presence
      t.timestamps
    end
  end
end
