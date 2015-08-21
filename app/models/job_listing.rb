class JobListing < ActiveRecord::Base
	has_and_belongs_to_many :hth_grad
	belongs_to :recruiter
	belongs_to :company
end
