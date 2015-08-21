class CreateRecruiters < ActiveRecord::Migration
  def change
    create_table :recruiters do |t|
      t.integer :company_id
      t.string :recruiter_name
      t.string :recruiter_email
      t.integer :recruiter_phone

      t.timestamps null: false
    end
  end
end
