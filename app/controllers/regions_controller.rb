class RegionsController < ApplicationController

  # GET: /regions
  get "/regions" do
    erb :"/regions/index.html"
  end

  # GET: /regions/new
  get "/regions/new" do
    erb :"/regions/new.html"
  end

  # POST: /regions
  post "/regions" do
    redirect "/regions"
  end

  # GET: /regions/5
  get "/regions/:id" do
    erb :"/regions/show.html"
  end

  # GET: /regions/5/edit
  get "/regions/:id/edit" do
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
