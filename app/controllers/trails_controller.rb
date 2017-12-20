class TrailsController < ApplicationController

  get "/trails" do
    if Helpers.logged_in?(session)
      @trails = Trail.all
      erb :"/trails/index.html"
    else
      redirect "/"
    end
  end

  get "/trails/new" do
    if Helpers.logged_in?(session)
      erb :"/trails/new.html"
    else
      redirect "/"
    end
  end

  post "/trails" do
    if !params[:trail_id].nil?
      @trail = Trail.find_by_id(params[:trail_id])
    else
      @trail = Trail.new(params[:trail])
      if Trail.exists?(name: params[:trail][:name])
        redirect '/trails/new'
      end
      if !params[:region][:name].empty?
        @trail.region = Region.find_or_initialize_by(params[:region])
      end
    end
    @trail.hikers << Helpers.current_user(session)
    @trail.save
    redirect "/trails"
  end

  get "/trails/:slug" do
    if Helpers.logged_in?(session)
      @trail = Trail.find_by_slug(params[:slug])
      erb :"/trails/show.html"
    else
      redirect "/"
    end
  end

  get "/trails/:slug/edit" do
    if Helpers.logged_in?(session)
      @trail = Trail.find_by_slug(params[:slug])
      erb :"/trails/edit.html"
    else
      redirect "/"
    end
  end

  patch '/trails/:slug' do
    @trail = Trail.find_by_slug(params[:slug])
    @trail.update(params[:trail])
    #binding.pry
    redirect "/trails/#{@trail.slug}"
  end

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
