class AddMoreColumnsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string
    add_column :users, :gender, :string
    add_column :users, :ethnicity, :string
    add_column :users, :age, :integer
    add_column :users, :location, :string
    add_column :users, :bio, :text
    add_column :users, :physical_attributes, :text
  end
end
