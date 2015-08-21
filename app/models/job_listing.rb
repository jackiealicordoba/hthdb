class JobListing < ActiveRecord::Base
	has_and_belongs_to_many :HthGrad
	belongs_to :Recruiter
	belongs_to :Company
end
