class SessionsController < ApplicationController

  get '/login' do
    erb :"sessions/login.html"
  end
  
  post '/login' do
  end
  
  get '/logout' do
    redirect "/welcome"
  end
end
