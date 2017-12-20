class HikersController < ApplicationController

  get "/hikers" do
    if Helpers.logged_in?(session)
      @hikers = Hiker.all
      erb :"/hikers/index.html"
    else
      redirect "/"
    end
  end

  get "/hikers/new" do
    if Helpers.logged_in?(session)
      redirect "/trails"
    else
      erb :"/hikers/new.html"
    end
  end

  post "/hikers" do
    #refactor and consider adding flash message for the error
    @hiker = Hiker.new(:username => params[:username], :password => params[:password])
    if params[:username].empty? || params[:password].empty? || Hiker.exists?(username: params[:username])
      redirect "/hikers/new"
    else
      @hiker.save
      session[:id] = @hiker.id
      redirect "/hikers"
    end
  end

  get "/hikers/:slug" do
    if Helpers.logged_in?(session)
      @hiker = Hiker.find_by_slug(params[:slug])
      erb :"/hikers/show.html"
    else
      redirect "/"
    end
  end

  # # GET: /hikers/5/edit
  # get "/hikers/:id/edit" do
  #   erb :"/hikers/edit.html"
  # end

  # # PATCH: /hikers/5
  # patch "/hikers/:id" do
  #   redirect "/hikers/:id"
  # end

  # # DELETE: /hikers/5/delete
  # delete "/hikers/:id/delete" do
  #   redirect "/hikers"
  # end
end
