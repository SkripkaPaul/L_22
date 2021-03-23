#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'pony'
require 'sqlite3'


def is_barber_exists? db, name
	db.execute('select * from barbers where name=?', [name]).length > 0
end

def seed_db db, barbers

	barbers.each do |barber|

		if !is_barber_exists? db, barber 
			db.execute 'insert into barbers (name) values (?)', [barber]
		end
	end

end

def get_db
	db = SQLite3::Database.new 'visit.db'
	db.results_as_hash = true
	return db 
end

configure do

db = get_db
db.execute 'CREATE TABLE IF NOT EXISTS "visit" 
		(
			"id" INTEGER,
			"name" TEXT,
			"phone" INTEGER,
			"date_visit" INTEGER,
			"barber" TEXT, 
			"color" TEXT, PRIMARY KEY("id" AUTOINCREMENT)
			)'

db.execute 'CREATE TABLE IF NOT EXISTS "barbers" 
		(
			"id" INTEGER,
			"name" TEXT,
			 PRIMARY KEY("id" AUTOINCREMENT)
			)'		

seed_db db, ['Walter White', 'Jessie Pinkman', 'Gus Fring', 'Joe Trebiani']
end

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

before do

	db = get_db
	@barb = db.execute 'SELECT * FROM barbers '  

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


	db = get_db
	db.execute 'insert into visit 

			(
			name, 
			phone, 
			date_visit, 
			barber, 
			color
			) values (?,?,?,?,?)', [@user_name, @user_phone, @date_visit, @barber, @colorpicker]



	
	# @f = File.open "./public/appointment.txt", "a"
	# @f.write " Name - #{@user_name}, phone number #{@user_phone}, date visit #{@date_visit}, time visit #{@time_visit} barber - #{@barber}\n"
	# @f.close

	# @f = File.open "./public/contacts.txt", "a"
	# @f.write " Name - #{@user_name}, phone number #{@user_phone} 	\n"
	# @f.close

	erb :message
end

post '/contacts' do
  @username = params[:username]
  @message = params[:message]
 
Pony.mail({
  :to => 'xxxxxxxxxx@rambler.ru'	,
  :from => 'zxc@gmail.com', 
  :via => :smtp,
  :subject => "Новое сообщение от пользователя #{@username}",
  :body => "#{@message}",
  :via_options => {
    :address              => 'smtp.gmail.com',
    :port                 => '587',
    :enable_starttls_auto => true,
    :user_name            => 'zxc',
    :password             => 'zxc',
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

	

	
	db = get_db
	
	@one = db.execute 'SELECT * FROM visit ' 
		


	erb :show
end 

	
	

	# if @login == 'admin' && @password == 'secret' 

	
	


	# else
	# 'Wrong password or login'
	# end










