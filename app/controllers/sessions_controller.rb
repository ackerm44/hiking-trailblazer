class SessionsController < ApplicationController

  get '/login' do
    if Helpers.logged_in?(session)
      redirect "/hikers/#{Helpers.current_user(session).slug}"
    else
      erb :"/sessions/login.html", :layout => :layout_loggedout
    end
  end
  
  post '/login' do
    @hiker = Hiker.find_by(:username => params[:username])
    if @hiker && @hiker.authenticate(params[:password])
      session[:id] = @hiker.id
      redirect "/hikers/#{@hiker.slug}"
    else
      flash[:log_in_error] = "Username or Password Incorrect"
      redirect "/login"
    end
  end
  
  get '/logout' do
    if Helpers.logged_in?(session)
      session.clear
      redirect "/login"
    else
      redirect "/"
      flash[:sign_in_message] = "Please log-in"
    end
  end
end
