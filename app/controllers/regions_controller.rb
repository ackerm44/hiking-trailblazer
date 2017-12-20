class RegionsController < ApplicationController

  # GET: /regions
  get "/regions" do
    if Helpers.logged_in?(session)
      @regions = Region.all
      erb :"/regions/index.html"
    else
      redirect "/"
    end
  end

  # GET: /regions/nw-michigan
  get "/regions/:slug" do
    @region = Region.find_by_slug(params[:slug])
    erb :"/regions/show.html"
  end

  # GET: /regions/nwmichigan/edit
  get "/regions/:slug/edit" do
    @region = Region.find_by_slug(params[:slug])
    erb :"/regions/edit.html"
  end

  # PATCH: /regions/5
  patch "/regions/:id" do
    redirect "/regions/:id"
  end

  # DELETE: /regions/5/delete
  delete "/regions/:id/delete" do
    redirect "/regions"
  end
end
