class CreateJobListings < ActiveRecord::Migration
  def change
    create_table :job_listings do |t|
      t.integer :company_id
      t.integer :recruiter_id
      t.string :company_name
      t.string :job_title
      t.string :job_location
      t.string :job_skills
      t.date :job_deadline
      t.text :job_description

      t.timestamps null: false
    end
  end
end
