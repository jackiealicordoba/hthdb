class CreateHthGrads < ActiveRecord::Migration
  def change
    create_table :hth_grads do |t|
      t.string :username
      t.string :password
      t.string :first_name
      t.string :last_name
      t.integer :phone_number
      t.string :email

      t.timestamps null: false
    end
  end
end
