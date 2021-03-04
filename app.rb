#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

get '/' do
	erb "Hello!!! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"			
end

get '/about' do
	erb :about
end

get '/visit' do 
	erb :visit
end

get '/contacts' do
	erb :contacts
end

get '/something' do
	erb :something
end

post '/visit' do

	@user_name = params[:username]
	@user_phone = params[:userphone]
	@date_visit = params[:datevisit]
	@time_visit = params[:timevisit]

	@title = 'Thank you'
	@message = "Dear #{@user_name}, you'r visit is date #{@date_visit}, time #{@time_visit}"

	f = File.open "./public/appointment.txt", "a"
	f.write " Name - #{@user_name}, phone number #{@user_phone}, date visit #{@date_visit}, time visit #{@time_visit}\n"
	f.close

	f = File.open "./public/contacts.txt", "a"
	f.write " Name - #{@user_name}, phone number #{@user_phone} 	\n"
	f.close

	erb :message
end

post '/contacts' do

end