require 'rubygems'
require 'sinatra'
require_relative './ruby-danfe/lib/ruby_danfe'

configure { set :server, :puma }

post '/' do
  file = params[:file]
  begin
    filename = "/tmp/#{Time.now.to_f * 1000}_#{file[:filename]}.pdf"
    RubyDanfe.generate(filename, file[:tempfile])
    send_file filename, type: :pdf
  rescue => e
    message = "Failed to convert file: #{file[:filename]}"
    status 500
    body message
    raise e, message
  end
end
