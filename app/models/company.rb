class Company < ActiveRecord::Base
	has_many :Recruiter
	has_many :JobListing
end
