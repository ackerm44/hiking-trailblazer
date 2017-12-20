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
  
  #Validation that only one region is selected
  post "/trails" do
    @trail = Trail.new(params[:trail])
    if !params[:region][:name].empty?
      @trail.region = Region.find_or_initialize_by(params[:region])
    end
    @trail.hikers << Helpers.current_user(session)
    @trail.save
    redirect "/trails"
  end

  # GET: /trails/5
  get "/trails/:slug" do
    if Helpers.logged_in?(session)
      @trail = Trail.find_by_slug(params[:slug])
      erb :"/trails/show.html"
    else
      redirect "/"
    end
    
  end

  # GET: /trails/days-river-trail/edit
  get "/trails/:slug/edit" do
    if Helpers.logged_in?(session)
      @trail = Trail.find_by_slug(params[:slug])
      erb :"/trails/edit.html"
    else
      redirect "/"
    end
  end

  patch "/trails/:slug" do
    @trail = Trail.find_by_slug(params[:slug])
    @trail.update(params[:trail])
    binding.pry
    redirect "/trails/#{@trail.slug}"
  end

  # DELETE: /trails/days-river-trail/delete
  delete "/trails/:slug" do
    if Helpers.logged_in?(session)
      @trail = Trail.find_by_slug(params[:slug])
      @trail.destroy
      redirect '/login'
    else
      redirect "/"
    end
  end
end
