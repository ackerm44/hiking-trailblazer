class SessionsController < ApplicationController

  get '/login' do
    if Helpers.logged_in?(session)
      redirect "/hikers/#{Helpers.current_user(session).slug}"
    else
      erb :"/sessions/login.html"
    end
  end
  
  post '/login' do
    @hiker = Hiker.find_by(:username => params[:username])
    if @hiker && @hiker.authenticate(params[:password])
      session[:id] = @hiker.id
      redirect "/hikers/#{@hiker.slug}"
    else
      redirect "/login"
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
