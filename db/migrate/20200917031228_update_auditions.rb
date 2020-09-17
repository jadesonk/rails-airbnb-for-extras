class UpdateAuditions < ActiveRecord::Migration[6.0]
  def change
    remove_reference :auditions, :job, foreign_key: true
    add_column :auditions, :application_details, :text
    add_reference :auditions, :role, foreign_key: true
  end
end
