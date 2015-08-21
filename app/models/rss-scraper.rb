require 'feedjira'
require 'date'

### get_text_between ###
#str: string to extract text from
#start: (string) begin grabbing text at the index where start first appears
#finish: stop grabbing when this char is encountered
#default: what string to put in db if no result

def get_text_between(str, start, finish, default)
	puts("string to grab text from: " + str)
	new_str = ""
	current_char_index = str.index(start)
	if current_char_index != nil
		while str[current_char_index] != finish
			new_str = new_str + str[current_char_index]
			current_char_index += 1
		end
	else
		new_str = default
	end
	return new_str
end

def debug_feed(feed)
	feed.entries.length.times do |i|
		puts("i is: " + i.inspect)
		puts("")
		puts("title: " + feed.entries[i].title)
		job_title = feed.entries[i].title
		puts("job_title: " + job_title)
		puts("")
		puts("url: " + feed.entries[i].url)
		puts("")
		puts("published: " + feed.entries[i].published.inspect)
		puts("")

		#puts("categories: " + feed.entries[i].categories)
		puts("")
		puts("entry id: " + feed.entries[i].entry_id)
		puts("")
		job_description = feed.entries[i].summary
		puts("job_description: " + job_description)

		puts("")
		puts("content: " + feed.entries[i].content)
		puts("")
		contentString = (feed.entries[i].content).downcase

		### parse deadline ###
		job_deadline = get_text_between(contentString, "deadline", '<', "rolling deadline")
		puts("job_deadline: " + job_deadline)

		### parse recruiter name###
		recruiter_id = get_text_between(contentString, "contact name", '<', "no contact info")
		puts("Recruiter Name: " + recruiter_id)

		### parse recruiter email###
		recruiter_email = get_text_between(contentString, "email", '<', "no contact email")
		puts("recruiter_email: " + recruiter_email)

		### parse internship/job location ###
		job_location = get_text_between(contentString, "location", '<', "no location")
		puts("Location: " + job_location)
		### done parsing location ###

		### parse recruiter phone###
		recruiter_phone = get_text_between(contentString, "phone", '<', "no contact phone number")
		puts("recruiter_phone: " + recruiter_phone)

		### parse skills###
		job_skills = get_text_between(contentString, "skills required", '<', "no skills listed")
		puts("Skills: " + job_skills)

		### parse company name###
		company_name = get_text_between(contentString, "company", '<', "no company listed")
		puts("Company Name: " + company_name)

		### parse company website ###
		company_website = get_text_between(contentString, "www.", '<', "no website listed")
		puts("company_website: " + company_website)

		### parse about company###
		company_about = get_text_between(contentString, "about the company", '<', "no company information")
		puts("company_website: " + company_about)


		i += 1
		puts("")
		puts("")
		puts("")
		puts("")
		puts("")
	end
end

def process_feed(feed)
	feed.entries.each do |entry|
		job_title = entry.title
		job_description = entry.summary

		contentString = entry.content.downcase

		begin
			job_deadline = Date.parse(get_text_between(contentString, "deadline", '<', ""))
		rescue ArgumentError
			job_deadline = Date.new
		end


		recruiter_name = get_text_between(contentString, "contact name", '<', "no contact info")
		recruiter_email = get_text_between(contentString, "email", '<', "no contact email")
		job_location = get_text_between(contentString, "location", '<', "no location")
		recruiter_phone = get_text_between(contentString, "phone", '<', "no contact phone number")
		job_skills = get_text_between(contentString, "skills required", '<', "no skills listed")
		company_name = get_text_between(contentString, "company", '<', "no company listed")
		company_website = get_text_between(contentString, "www.", '<', "no website listed")
		company_about = get_text_between(contentString, "about the company", '<', "no company information")


		#INSERT INTO company (company_name, company_about, company_website) VALUES (company_name, company_about, company_website);
		company = Company.create(
			company_name: company_name,
			company_about: company_about,
			company_website: company_website,
		)

		#INSERT INTO recruiter (company_name, recruiter_id, recruiter_email, recruiter_phone) VALUES (company_name, recruiter_id, recruiter_email, recruiter_phone);
		recruiter = Recruiter.create(
			company: company,
			recruiter_name: recruiter_name,
			recruiter_email: recruiter_email,
			recruiter_phone: recruiter_phone,
		)

		#INSERT INTO job_listing (company_name, recruiter_id, job_title, job_location, job_deadline, job_description, job_skills) VALUES (company_name, recruiter_id, job_title, job_location, job_deadline, job_description, job_skills);
		job_listing = JobListing.create(
			company: company,
			recruiter: recruiter,
			job_title: job_title,
			job_location: job_location,
			job_deadline: Date.parse(job_deadline),
			job_description: job_description,
			job_skills: job_skills,
		)
	end
end


url = "http://www.hackthehood.org/4/feed"
rss_feed = Feedjira::Feed.fetch_and_parse url

process_feed(rss_feed)
