class JobListingsController < ApplicationController
	respond_to :html, :json

	def index
		@job_listings = JobListing.all
		respond_with @job_listings
	end
	def new
		@job_listing = JobListing.new
		respond_with @job_listing
	end
	def create
		@job_listing = JobListing.create(job_listings_params)
		respond_with @job_listing
	end
	def job_listings_params
		params.require(:job_listings).permit(:company_name, :job_title, :job_location, :job_skills, :job_deadline, :job_description)
	end
end

