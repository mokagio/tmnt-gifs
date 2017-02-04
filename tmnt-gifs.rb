require 'sinatra'
require 'json'

post '/' do
  # Might want to add a token read from env variable
  #status 500 unless request['token'] == 'your-token-here'

  # TODO: pick image based on reaction
  # reaction = request['text']

  content_type :json
  {
    attachments: [
      {
        image_url: 'https://media.giphy.com/media/10LNj580n9OmiI/giphy.gif'
      }
    ]
  }.to_json
end

get '/' do
  "TMNT Gifs\n\nCowabunga!"
end
