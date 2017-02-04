require 'sinatra'
require 'json'

post '/' do
  # Might want to add a token read from env variable
  #status 500 unless request['token'] == 'your-token-here'

  text, image_url = text_and_image(for_reaction: request['text'])

  content_type :json
  {
    title: 'TMNT Gifs',
    text: text,
    attachments: [
      {
        image_url: image_url,
      }
    ]
  }.to_json
end

get '/' do
  "TMNT Gifs\n\nCowabunga!"
end

private

def text_and_image(for_reaction:)
  image_url = gif_url_or_nil(for_reaction: for_reaction)

  if image_url.nil?
    # return an explanation meassage and a random gif
    return "I don't have a good reaction for \"#{for_reaction}\", so I'm returning a random one.", random_value(gifs)
  else
    return '', image_url
  end
end

def gif_url_or_nil(for_reaction:)
  case for_reaction
  when 'happy'
    gifs[:happy]
  when 'high five'
    gifs[:high_five]
  when 'scared', 'scary'
    gifs[:scary]
  when 'work', 'hard work', 'focus'
    gifs[:work]
  else
    nil
  end
end

def gifs
  {
    happy: 'https://media.giphy.com/media/mw2Q2CsUaBFIY/giphy.gif',
    high_five: 'https://media.giphy.com/media/10LNj580n9OmiI/giphy.gif',
    scary: 'https://media.giphy.com/media/3dcoLqDDjd9pC/giphy.gif',
    work: 'https://media.giphy.com/media/cFdHXXm5GhJsc/giphy.gif'
  }
end

def random_value(hash)
  # using last because the result of to_a.sample
  # will be [key, value]
  hash.to_a.sample.last
end
