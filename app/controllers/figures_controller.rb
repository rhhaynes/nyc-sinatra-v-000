class FiguresController < ApplicationController
  
    get "/figures" do
      @figures = Figure.all
      erb :"figures/index"
    end

    get "/figures/new" do
      erb :"figures/new"
    end
    
    post "/figures" do
      figure = Figure.new(params["figure"])
      if !!figure.save
        figure.landmarks << Landmark.create(params["landmark"]) unless params["landmark"]["name"].empty?
        figure.titles    <<    Title.create(params["title"])    unless params["title"]["name"].empty?
        figure.save
        redirect "/figures/#{figure.id}"
      else
        redirect "/figures/new"
      end
    end

    get "/figures/:id" do
      @figure = Figure.find_by(:id => params["id"])
      erb :"figures/show"
    end

    get "/figures/:id/edit" do
      @figure = Figure.find_by(:id => params["id"])
      erb :"figures/edit"
    end

    patch "/figures/:id" do
      figure = Figure.find_by(:id => params["id"])
      if !!figure.update(params["figure"])
        figure.landmarks << Landmark.create(params["landmark"]) unless params["landmark"]["name"].empty?
        figure.titles    <<    Title.create(params["title"])    unless params["title"]["name"].empty?
        figure.save
        redirect "/figures/#{figure.id}"
      else
        redirect "/figures/#{figure.id}/edit"
      end
    end
end