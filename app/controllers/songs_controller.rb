require 'sinatra/flash'

class SongsController < ApplicationController
  register Sinatra::Flash


  get '/songs' do
    @songs = Song.all
    erb :'/songs/index'
  end

  get '/songs/new' do
    erb :'/songs/new'
  end

  post '/songs' do
  @song = Song.create(:name => params["Name"])
  @song.artist = Artist.find_or_create_by(:name => params["Artist Name"])

  @song.genre_ids = params[:genres]


#binding.pry

  @song.save

  flash.next[:message] = "Successfully created song."
  redirect "/songs/#{@song.slug}"
  end




  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    erb :'/songs/show'
  end

  get '/songs/:slug/edit' do
    @song = Song.find_by_slug(params[:slug])
    erb :'/songs/edit'
  end


  patch '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    @song.update(params["song_name"])

    @song.artist = Artist.find_or_create_by(:name => params["artist_name"])
    @song.genre_ids = params[:genres]

    @song.save

    flash.next[:message] = "Successfully updated song."

    redirect "/songs/#{@song.slug}"
  end


end
