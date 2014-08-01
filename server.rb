require 'rubygems'
require 'sinatra'
require_relative './ruby-danfe/lib/ruby_danfe'

post '/' do
  file = params[:file]
  request_time = Time.now.to_f * 1000
  filename = "/tmp/#{request_time}_#{file[:filename]}.pdf"
  RubyDanfe.generate(filename, file[:tempfile])
  send_file filename, type: :pdf
end
