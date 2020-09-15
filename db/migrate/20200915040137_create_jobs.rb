class CreateJobs < ActiveRecord::Migration[6.0]
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :description
      t.date :application_deadline_date
      t.string :location
      t.date :shoot_date
      t.string :job_status
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
