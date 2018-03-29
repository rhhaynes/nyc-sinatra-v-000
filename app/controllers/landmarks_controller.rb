class LandmarksController < ApplicationController
  
  get "/" do
    redirect "/landmarks"
  end

  get "/landmarks" do
    @landmarks = Landmark.all
    @figures   = Figure.all
    erb :"landmarks/index"
  end

  get "/landmarks/new" do
    erb :"landmarks/new"
  end
  
  post "/landmarks" do
    landmark = Landmark.new(
      :name           => params["landmark"]["name"],
      :year_completed => params["landmark"]["year_completed"].to_i
      )
    if !!landmark.save
      redirect "/landmarks"
    else
      redirect "/landmarks/new"
    end
  end

  get "/landmarks/:id" do
    @landmark = Landmark.find_by(:id => params["id"])
    erb :"landmarks/show"
  end

  get "/landmarks/:id/edit" do
    @landmark = Landmark.find_by(:id => params["id"])
    erb :"landmarks/edit"
  end

  patch "/landmarks/:id" do
    landmark = Landmark.find_by(:id => params["id"])
    landmark.name           = params["landmark"]["name"]
    landmark.year_completed = params["landmark"]["year_completed"]
    if !!landmark.save
      redirect "/landmarks/#{landmark.id}"
    else
      redirect "/landmarks/#{landmark.id}/edit"
    end
  end
end
