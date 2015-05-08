require 'sinatra/base'
require './lib/pivotal-api'

class App < Sinatra::Base
  get '/' do
    api = PivotalApi.build_from_env

    @selected_label = params[:label]
    @project = api.find_project
    @icebox = api.find_cards(:icebox, @selected_label)
    @backlog = api.find_cards(:backlog, @selected_label)
    @doing = api.find_cards(:doing, @selected_label)
    @done = api.find_cards(:done, @selected_label)
    @labels = api.find_labels

    erb :index
  end

  get '/card/:id' do
    api = PivotalApi.build_from_env

    @project = api.find_project
    @card = api.find_card(params['id'])

    erb :detailed_card
  end
end