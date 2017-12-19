class HikersController < ApplicationController

  # GET: /hikers
  get "/hikers" do
    erb :"/hikers/index.html"
  end

  # GET: /hikers/new
  get "/hikers/new" do
    erb :"/hikers/new.html"
  end

  # POST: /hikers
  post "/hikers" do
    @hiker = Hiker.new(:username => params[:username], password => params[:password])
    if params[:username].empty? || params[:password].empty?
      redirect "/hikers/new"
    else
      @hiker.save
      redirect "/hikers"
    end
  end

  # GET: /hikers/5
  get "/hikers/:id" do
    erb :"/hikers/show.html"
  end

  # GET: /hikers/5/edit
  get "/hikers/:id/edit" do
    erb :"/hikers/edit.html"
  end

  # PATCH: /hikers/5
  patch "/hikers/:id" do
    redirect "/hikers/:id"
  end

  # DELETE: /hikers/5/delete
  delete "/hikers/:id/delete" do
    redirect "/hikers"
  end
end
