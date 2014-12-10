class CreateInstitutions < ActiveRecord::Migration
  def change
    create_table :institutions do |t|
      t.string :name
      t.string :phone_number
      t.string :email
      t.string :site
      t.string :contact
      t.timestamps
    end
  end
end
