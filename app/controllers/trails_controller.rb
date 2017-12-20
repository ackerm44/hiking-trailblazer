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
    @trail = Trail.find_by_slug(params[:slug])
    if Helpers.logged_in?(session) && Helpers.current_user(session) == @trail.hikers[0]
      #binding.pry
      erb :"/trails/edit.html"
    elsif Helpers.logged_in?(session) && Helpers.current_user(session) != @trail.hikers[0]
      #Add a flash message about error
      redirect "/trails/#{@trail.slug}"
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
    @trail = Trail.find_by_slug(params[:slug])
    if Helpers.logged_in?(session) && Helpers.current_user(session) == @trail.hikers[0]
      @trail.destroy
      redirect '/trails'
    elsif Helpers.logged_in?(session) && Helpers.current_user(session) != @trail.hikers[0]
      redirect "/trails/#{@trail.slug}"
    else
      redirect "/"
    end
  end
end
