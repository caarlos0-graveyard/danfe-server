# encoding:utf-8
require 'rubygems'
require 'sinatra'
require 'haml'
require 'ruby_danfe'
require 'redis'
require 'json'

SUCCESSES = 'success_count'
ERRORS = 'error_count'
$redis = Redis.new

set :server, :puma
set :haml, :format => :html5

get '/' do
  haml :index, locals: { message: '' }, layout: :template
end

get '/api' do
  haml :api, layout: :template
end

post '/' do
  file = params[:file]
  return show_error("Por favor, selecione um arquivo.") unless file
  send_file convert(file), type: :pdf rescue convertion_error(file)
end

get '/status.json' do
  content_type :json
  {
    successes: $redis.get(SUCCESSES),
    errors: $redis.get(ERRORS)
  }.to_json
end


private

def incr(key)
  $redis.pipelined { $redis.incr key }
end

def convertion_error(file)
  incr ERRORS
  show_error """
        Falha ao converter arquivo '#{file[:filename]}'.
        Tem certeza escolheu um arquivo <kbd>.xml</kbd> de NF-e válido?
      """
end

def convert(file)
  path = "/tmp/#{Time.now.to_f * 1000}_#{file[:filename]}.pdf"
  RubyDanfe.generate(path, file[:tempfile])
  incr SUCCESSES
  path
end

def show_error(message)
  status 500
  haml :index, locals: { message: message }, layout: :template
end
