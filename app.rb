#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'pony'


get '/' do
	erb "Hello!!! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"			

end

get '/about' do
	erb :about
end

get '/admin' do

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

	hh = { 	:username => 'Укажите имя',
			:userphone => 'Укажите номер телефона',
			:datevisit => 'Укажите дату визита',
			:timevisit => 'Укажите время визита'}

			@error = hh.select {|key,_| params[key] == ""}.values.join (", ")

			if @error != ""
				return erb :visit
			end

	@colorpicker = params[:colorpicker]

	@title = 'Thank you'
	@second_message = "Dear #{@user_name}, you'r visit is date #{@date_visit}, time #{@time_visit} you'r barber is #{@barber}  you color is #{@colorpicker}"

	@f = File.open "./public/appointment.txt", "a"
	@f.write " Name - #{@user_name}, phone number #{@user_phone}, date visit #{@date_visit}, time visit #{@time_visit} barber - #{@barber}\n"
	@f.close

	@f = File.open "./public/contacts.txt", "a"
	@f.write " Name - #{@user_name}, phone number #{@user_phone} 	\n"
	@f.close

	erb :message
end

post '/contacts' do
  @username = params[:username]
  @message = params[:message]
 
Pony.mail({
  :to => 'xxxxxxxxxx@rambler.ru'	,
  :from => 'ckripka222@gmail.com', 
  :via => :smtp,
  :subject => "Новое сообщение от пользователя #{@username}",
  :body => "#{@message}",
  :via_options => {
    :address              => 'smtp.gmail.com',
    :port                 => '587',
    :enable_starttls_auto => true,
    :user_name            => 'ckripka222',
    :password             => 'xxxxxxxxxxxxxx',
    :authentication       => :plain, 
    :domain               => "localhost:4567" 
  }
})
  erb :contacts
end

post '/admin' do

	@login = params[:login]
	@password = params[:password]
	
	@title = 'You in admin room'
	@first_message = 'Visit'
	@second_message = File.read "./public/appointment.txt"

	if @login == 'admin' && @password == 'secret' 
	
	erb :message
	else
	'Wrong password or login'
	end

end










