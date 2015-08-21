class Recruiter < ActiveRecord::Base
	belongs_to :company
	has_many :job_listings
end
