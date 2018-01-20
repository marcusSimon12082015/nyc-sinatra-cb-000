class FiguresController < ApplicationController
  set :views, Proc.new { File.join(root, "../views/figures") }
  register Sinatra::Twitter::Bootstrap::Assets

  get '/figures' do
    @figures = Figure.all
    erb :index
  end

  get '/figures/new' do
    erb :new
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :show
  end

  post '/figures' do
    @figure = Figure.create(name: params[:figure_name])

    #binding.pry
    if !params[:figure][:title_ids].nil?
      params[:figure][:title_ids].each do |title|
        @figure.titles << Title.find(title.to_i)
      end
    end

    if !params[:figure][:landmark_ids].nil?
      params[:figure][:landmark_ids].each do |landmark|
        @figure.landmarks << Landmark.find(landmark.to_i)
      end
    end

    if !params[:landmark][:name].empty?
      landmark_new = Landmark.create(name: params[:landmark][:name])
      @figure.landmarks << landmark_new
    end

    if !params[:title][:name].empty?
      title_new = Title.create(name: params[:title][:name])
      @figure.titles << title_new
      #binding.pry
    end
  end
end
