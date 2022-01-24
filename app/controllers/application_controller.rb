class ApplicationController < Sinatra::Base

  # This line to set Content-Type header for all responses
  set :default_content_type, 'application/json'

  get '/' do
    { message: "Hello world" }.to_json
  end

  get '/games' do
    # get all the games from the database (using ActiveRecord)
    # games = Game.all

    # games = Game.all.order(:title) # Sort games by title instead of default sort order (ID)

    # games = Game.all.order(:title).limit(10) # Return just first 10 results

    # return a JSON response with an array of all the game data
    # games.to_json
    Game.all.to_json # Side-test: Direct method chaining also works.
  end

  get '/games/:id' do
    # look up the game in the database using its ID
    game = Game.find(params[:id])
    # send a JSON-formatted response of the game data
    # game.to_json
    # include associated reviews in the JSON response
    # game.to_json(include: :reviews)
    # include associated users with each review
    # game.to_json(include: { reviews: { include: :user } })
    # selectivity re: which attributes are returned from each model via ONLY
    game.to_json(only: [:id, :title, :genre, :price], include: { reviews: { only: [:comment, :score], include: { user: {only: [:name] }
      } }
    })
  end

end
