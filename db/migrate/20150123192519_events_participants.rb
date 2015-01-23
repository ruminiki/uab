class EventsParticipants < ActiveRecord::Migration
  def change
    create_table :events_participants do |t|
      t.string :name
      t.string :email
      t.date :notified_at
      t.integer :event_id
      t.integer :employee_id

      t.timestamps
    end
  end
end
