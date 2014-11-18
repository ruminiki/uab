class StudentsUpdate < ActiveRecord::Migration
  def change
  	add_column :students, :rg, :string
  	add_column :students, :cpf, :string
  	add_column :students, :sanguine_type, :string
  end
end
