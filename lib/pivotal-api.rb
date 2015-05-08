require 'json'
require 'yaml'
require 'faraday'
require './models/card'
require './models/label'
require './models/project'

class PivotalApi
  def initialize(api_key, project)
    @api_key = api_key
    @project = project
    @conn = Faraday.new(url: "https://www.pivotaltracker.com") do |faraday|
      faraday.adapter  Faraday.default_adapter
    end
  end

  def self.build_from_yaml
    config = YAML.load_file('config.yml')

    new(config["api_key"], config["project"])
  end

  def self.build_from_env
    new(ENV["pivotal_api_key"], ENV["pivotal_project"])
  end

  def get(endpoint)
    response = @conn.get do |req|
      req.url "/services/v5/projects/#{@project}#{endpoint}"
      req.headers['X-TrackerToken'] = @api_key
    end
    JSON.parse(response.body)
  end

  def find_project
    Project.new(get(''))
  end

  def find_card(id)
    Card.new(get("/stories/#{id}"))
  end

  def find_cards(filter, label)
    states = {
      icebox: [ 'unscheduled' ],
      backlog: [ 'unstarted', 'planned' ],
      doing: [ 'delivered', 'started', 'rejected' ],
      done: [ 'accepted', 'finished' ]
    }

    state = states[filter].join(',')
    labels = [ 'public' ]
    labels << label if label
    get("/stories?filter=state:#{state} #{labels.map { |label| "label:#{label}"  }.join(' ')}").map { |card| Card.new(card) }
  end

  def find_labels
    get('/labels').map { |label| Label.new(label) }
  end
end