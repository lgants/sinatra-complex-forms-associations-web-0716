class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    erb :'/pets/new'
  end

  post '/pets' do
    if !params[:owner][:name].empty?
      #the user DOES include a NEW owner
      @owner = Owner.create(params[:owner])
      @pet = Pet.create(name: params[:pet][:name], owner_id: @owner.id)
    else
      #the user does NOT include a NEW owner
      @pet = Pet.create(name: params[:pet][:name], owner_id: params[:pet][:owner_id][0].to_i)
    end
    redirect "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do
  @pet = Pet.find(params[:id])
  @pet.update(params["pet"])
  if !params["owner"]["name"].empty?
    #the user DOES include a NEW owner
    @pet.owner = Owner.create(name: params["owner"]["name"])
  end
  @pet.save
  redirect "pets/#{@pet.id}"
end


end
