class Recruiter < ActiveRecord::Base
	belongs_to :Company
	has_many :JobListing
end
