class TrailsController < ApplicationController

  # GET: /trails
  get "/trails" do
    if Helpers.logged_in?(session)
      @trails = Trail.all
      erb :"/trails/index.html"
    else
      redirect "/"
    end
  end

  # GET: /trails/new
  get "/trails/new" do
    if Helpers.logged_in?(session)
      erb :"/trails/new.html"
    else
      redirect "/"
    end
    
  end

  # POST: /trails
  post "/trails" do
    @trail = Trail.new(params[:trail])
    if !params[:region][:name].empty?
      @trail.region = Region.find_or_initialize_by(params[:region])
      @trail.save
    end
    binding.pry
    redirect "/trails"
  end

  # GET: /trails/5
  get "/trails/:id" do
    erb :"/trails/show.html"
  end

  # GET: /trails/5/edit
  get "/trails/:id/edit" do
    erb :"/trails/edit.html"
  end

  # PATCH: /trails/5
  patch "/trails/:id" do
    redirect "/trails/:id"
  end

  # DELETE: /trails/5/delete
  delete "/trails/:id/delete" do
    redirect "/trails"
  end
end
