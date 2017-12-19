class SessionsController < ApplicationController

  get '/login' do
    if Helpers.logged_in?(session)
      redirect '/trails'
    else
      erb :"/sessions/login.html"
    end
  end
  
  post '/login' do
    @hiker = Hiker.find_by(:username => params[:username])
    if @hiker && @hiker.authenticate(params[:password])
      session[:id] = @hiker.id
      redirect '/trails'
    else
      redirect "/hikers/#{@hiker.slug}"
    end
  end
  
  get '/logout' do
    #When logged out, show happy trails message and redirect to login
    if Helpers.logged_in?(session)
      session.clear
      redirect "/login"
    else
      redirect "/"
    end
  end
end
