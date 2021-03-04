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
	
	@title = 'Thank you'
	@message = "Dear #{@user_name} congratulation!"

	f = File.open "./public/barbertest.txt", "a"
	f.write " Name - #{@user_name}\n"
	f.close

	erb :message
end

