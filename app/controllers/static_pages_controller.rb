class StaticPagesController < ApplicationController
    require 'flickr'
    API_HASH = {api_key: ENV["pusher_key"]}
    USER_ID = '181876423@N06'

    def home
        @photos = []
        if params[:flickr_id]
            @flickr = Flickr.new(API_HASH)
            response = @flickr.request('people.getPublicPhotos', {'user_id' => params[:flickr_id]})
            response['photos']['photo'].each do |photo_attributes|
                photo = Flickr::Photo.new(nil, API_HASH, photo_attributes)
                @photos << photo.source('Small')
            end
        end
    end

    def home2#searches by tag, not user id
        @photos = []
        if params[:flickr_id]
            @flickr = Flickr.new(API_HASH)
            collection = @flickr.photos_search({tags: params[:flickr_id]})
            collection.each do |photo|
                @photos << photo.source('Small')
            end
        end
    end
end
