class HikersController < ApplicationController

  get "/hikers" do
    if Helpers.logged_in?(session)
      @hikers = Hiker.all
      erb :"/hikers/index.html"
    else
      flash[:sign_in_message] = "Please log-in"
      redirect "/"
      
    end
  end

  get "/hikers/new" do
    if Helpers.logged_in?(session)
      redirect "/hikers"
    else
      erb :"/hikers/new.html", :layout => :layout_loggedout
    end
  end

  post "/hikers" do
    @hiker = Hiker.new(:username => params[:username], :password => params[:password])
    if params[:username].empty? || params[:password].empty?
      flash[:hiker_error] = "Username and password fields must be filled out"
      redirect "/hikers/new"
    elsif Hiker.exists?(username: params[:username])
      flash[:hiker_error] = "Username already in use"
      redirect "/hikers/new"
    else
      @hiker.save
      session[:id] = @hiker.id
      redirect "/hikers/#{@hiker.slug}"
    end
  end

  get "/hikers/:slug" do
    @hiker = Hiker.find_by_slug(params[:slug])
    if Helpers.logged_in?(session) && Helpers.current_user(session) != @hiker
      erb :"/hikers/show.html"
    elsif Helpers.logged_in?(session) && Helpers.current_user(session) == @hiker
      erb :"/sessions/profile.html"
    else
      redirect "/"
      flash[:sign_in_message] = "Please log-in"
    end
  end

  delete "/hikers/:slug" do
    @hiker = Hiker.find_by_slug(params[:slug])
    binding.pry
    if Helpers.logged_in?(session) && Helpers.current_user(session) == @hiker
      @hiker.destroy
      session.clear
      redirect "/"
    elsif Helpers.logged_in?(session) && Helpers.current_user(session) != @hiker
      redirect "/hikers/#{@hiker.slug}"
    else
      redirect '/'
      flash[:sign_in_message] = "Please log-in"
    end
  end
end
