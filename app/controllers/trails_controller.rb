class TrailsController < ApplicationController

  get "/trails" do
    if Helpers.logged_in?(session)
      @trails = Trail.all
      erb :"/trails/index.html"
    else
      redirect "/"
      flash[:sign_in_message] = "Please log-in"
    end
  end

  get "/trails/new" do
    if Helpers.logged_in?(session)
      erb :"/trails/new.html"
    else
      redirect "/"
      flash[:sign_in_message] = "Please log-in"
    end
  end

  post "/trails" do
    #binding.pry
    @hiker = Helpers.current_user(session)
    if !params[:trail_id].nil?
      if @hiker.trails.ids.include?(params[:trail_id].to_i)
        flash[:trail_error] = "Trail already in profile."
        redirect '/trails/new'
      else
        @trail = Trail.find_by_id(params[:trail_id])
      end
    else !params[:trail].empty?
      @trail = Trail.new(params[:trail])
      if Trail.exists?(name: params[:trail][:name])
        flash[:trail_error] = "Trail already exists.  Select from above trail."
        redirect '/trails/new'
      end
      if params[:region][:name].empty? && params[:trail][:region_id].empty?
        flash[:trail_error] = "Please select or create a region"
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
      flash[:sign_in_message] = "Please log-in"
    end
  end

  get "/trails/:slug/edit" do
    @trail = Trail.find_by_slug(params[:slug])
    if Helpers.logged_in?(session) && Helpers.current_user(session) == @trail.hikers[0]
      erb :"/trails/edit.html"
    elsif Helpers.logged_in?(session) && Helpers.current_user(session) != @trail.hikers[0]
      #Add a flash message about error
      redirect "/trails/#{@trail.slug}"
    else
      redirect "/"
      flash[:sign_in_message] = "Please log-in"
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
      flash[:sign_in_message] = "Please log-in"
    end
  end
end
