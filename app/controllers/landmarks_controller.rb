class LandmarksController < ApplicationController
  set :views, Proc.new { File.join(root, "../views/landmarks") }
  register Sinatra::Twitter::Bootstrap::Assets

  get '/landmarks' do
    @landmarks = Landmark.all
    #binding.pry
    erb :index
  end

  get '/landmarks/new' do
    erb :new
  end

  get '/landmarks/:id' do
    @landmark = Landmark.find(params[:id])
    #binding.pry
    erb :show
  end

  get '/landmarks/:id/edit' do
    @landmark = Landmark.find(params[:id])
    #binding.pry
    erb :edit
  end

  patch '/landmarks/:id' do
    @landmark = Landmark.find(params[:id])
    #binding.pry
    @landmark.update(name: params[:name], year_completed: params[:year_completed])
    redirect to("/landmarks/#{@landmark.id}")
  end

  post '/landmarks' do
    Landmark.create(name: params[:landmark_name], year_completed: params[:landmark_year_completed])
  end
end
