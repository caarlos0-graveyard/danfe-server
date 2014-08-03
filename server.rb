# encoding:utf-8
require 'rubygems'
require 'sinatra'
require 'haml'
require_relative './ruby-danfe/lib/ruby_danfe'
configure { set :server, :puma }
set :haml, :format => :html5

get '/' do
  haml :index, locals: { message: '' }, layout: :template
end

get '/api' do
  haml :api, locals: { message: '' }, layout: :template
end

post '/' do
  file = params[:file]
  return show_error("Por favor, selecione um arquivo.") unless file
  send_file convert(file), type: :pdf rescue convertion_error(file)
end

private

def convertion_error(file)
  show_error """
        Falha ao converter arquivo '#{file[:filename]}'.
        Tem certeza escolheu um arquivo <kbd>.xml</kbd> de NF-e válido?
      """
end

def convert(file)
  path = "/tmp/#{Time.now.to_f * 1000}_#{file[:filename]}.pdf"
  RubyDanfe.generate(path, file[:tempfile])
  path
end

def show_error(message)
  status 500
  haml :index, locals: { message: message }, layout: :template
end
