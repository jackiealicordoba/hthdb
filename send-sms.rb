require 'rubygems'
require 'twilio-ruby'

def get_titles
	title_array = []
	filename = "output.txt"
	file_handle = open(filename).each_line do |line|
		if line.start_with?("title:")
			title_array.push(line[7..-1].chomp)
		end	
	end
	title_array
end

def send_sms(msg, numbers) 
	account_sid = "ACf2b5b15cf1f9c302580849aecf79c269"
	auth_token = "525cfd9eea183857f449a52258cd66ec"
	client = Twilio::REST::Client.new account_sid, auth_token
 
	from = "+13212333762" # Your Twilio number
	
	numbers.each do |number|
 	 client.account.messages.create(
 	 	:from => from,
 	 	:to => number,
    	:body => "New job on HackTheHood: #{msg}"
 	 )
 	 puts "Sent message to #{number}"
	end 
end

numbers = ["+13869604624", "+12269772255"]
titles = get_titles
titles.each do |title|
	send_sms(title, numbers)
end
