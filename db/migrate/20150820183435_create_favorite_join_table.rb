class CreateFavoriteJoinTable < ActiveRecord::Migration
  def change
    create_join_table :job_listings, :hth_grads
  end
end
