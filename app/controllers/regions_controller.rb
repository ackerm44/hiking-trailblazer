class RegionsController < ApplicationController

  get "/regions" do
    if Helpers.logged_in?(session)
      @regions = Region.all
      erb :"/regions/index.html"
    else
      redirect "/"
      flash[:sign_in_message] = "Please log-in"
    end
  end

  get "/regions/:slug" do
    if Helpers.logged_in?(session)
      @region = Region.find_by_slug(params[:slug])
      erb :"/regions/show.html"
    else
      redirect "/"
      flash[:sign_in_message] = "Please log-in"
    end
  end

end
