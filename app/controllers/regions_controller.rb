class RegionsController < ApplicationController
  ## A region can only be added when a trail is added
  ## All regions can be viewed, a single region can be viewed
  ## A region can be edited (name)
  ## A region cannot be deleted


  get "/regions" do
    if Helpers.logged_in?(session)
      @regions = Region.all
      erb :"/regions/index.html"
    else
      redirect "/"
    end
  end

  get "/regions/:slug" do
    if Helpers.logged_in?(session)
      @region = Region.find_by_slug(params[:slug])
      erb :"/regions/show.html"
    else
      redirect "/"
    end
  end

  # get "/regions/:slug/edit" do
  #   if Helpers.logged_in?(session)
  #     @region = Region.find_by_slug(params[:slug])
  #     erb :"/regions/edit.html"
  #   else
  #     redirect "/"
  #   end
  # end

  # patch '/regions/:slug' do
  #   @region = Region.find_by_slug(params[:slug])
  #   if @region.name.empty?
  #     redirect "/regions/#{@region.slug}/edit"
  #   else
  #     @region.update(params[:region])
  #     redirect "/regions/#{@region.slug}"
  #   end
  # end

  # delete "/regions/:slug/delete" do
  #   #Add validation that the original user can be the only one to delete
  #   if Helpers.logged_in?(session)
  #     @region = Region.find_by_slug(params[:slug])
  #     redirect "/regions"
  #   else
  #     redirect "/"
  #   end
  # end
end
