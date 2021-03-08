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

get '/admin' do

	@f = File.read "./public/appointment.txt"

	erb :admin
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

	@barber = params[:barbers]

	@title = 'Thank you'
	@message = "Dear #{@user_name}, you'r visit is date #{@date_visit}, time #{@time_visit} you'r barber is #{@barber}"

	f = File.open "./public/appointment.txt", "a"
	f.write " Name - #{@user_name}, phone number #{@user_phone}, date visit #{@date_visit}, time visit #{@time_visit} barber - #{@barber}\n"
	f.close

	f = File.open "./public/contacts.txt", "a"
	f.write " Name - #{@user_name}, phone number #{@user_phone} 	\n"
	f.close

	erb :message
end

post '/contacts' do

	@user_name = params[:username]
	@user_reviews = params[:reviews]

	f = File.open "./public/reviews.txt", "a"
	f.write " Name - #{@user_name},\n отзыв #{@user_reviews} \n"
	f.close

	erb :contacts 

end

post '/admin' do

	@login = params[:login]
	@password = params[:password]
	
	@title = 'Congratulation'
	@message = 'You in admin room'

	if @login == 'admin' && @password == 'secret' 
	
	erb :message
	else
	'Wrong password or login'
	end

end









