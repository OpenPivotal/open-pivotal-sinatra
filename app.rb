require 'sinatra/base'
require './lib/pivotal-api'

class App < Sinatra::Base
  get '/' do
    api = PivotalApi.build_from_env

    @project = api.find_project
    @icebox = api.find_cards(:icebox)
    @backlog = api.find_cards(:backlog)
    @doing = api.find_cards(:doing)
    @done = api.find_cards(:done)

    erb :index
  end

  get '/card/:id' do
    api = PivotalApi.build_from_env

    @project = api.find_project
    @card = api.find_card(params['id'])

    erb :detailed_card
  end
end