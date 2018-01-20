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
    #binding.pry
    erb :show
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    erb :edit
  end

  patch '/figures/:id' do
    @figure = Figure.find(params[:id])

    if !params[:new_landmark].empty?
      landmark = Landmark.find_or_create_by(name: params[:new_landmark])
      @figure.landmarks << landmark
    end
    @figure.update(name: params[:figure_name])
    redirect to("/figures/#{@figure.id}")
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

    if params[:landmark][:name].empty? == false
      #@figure.landmarks << Landmark.create(name: params[:landmark][:name])
      binding.pry
    end

    if params[:title][:name].empty? == false
      binding.pry
      #@figure.titles << Title.create(name: params[:title][:name])
    end

  end
end
