require 'flickraw'

class HomeController < ApplicationController
  def index
  end
  
  def flickr_photos
    flickr = Flickr.new(ENV['FLICKR_API_KEY'], ENV['FLICKR_API_SECRET'])
    user_id = params[:user_id]
    photos = flickr.people.getPublicPhotos(user_id: user_id)
  
    if photos.to_a.empty?
      @photo_urls = []
      flash[:error] = "No photos found for user ID #{user_id}."
    else
      @photo_urls = photos.map do |photo|
        FlickRaw.url(photo)
      end
    end
  end
end
