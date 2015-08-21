class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :company_name
      t.text :company_about
      t.string :company_website

      t.timestamps null: false
    end
  end
end
