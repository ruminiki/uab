class AddCityRefToStudent < ActiveRecord::Migration
  def change
    add_column :students, :city_id, :cities
  end
end
