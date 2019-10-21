require 'sinatra'
require 'sinatra/json'
require 'sinatra/reloader' if development?

Dir[File.dirname(__FILE__) + '/services/*.rb'].each {|file| require file }

class CorvaTestApp < Sinatra::Base
  get "*" do
    halt status 400
  end

  post '/compute/:request_id', :provides => :json do
    pass unless request.accept? 'application/json'
    request_id = params['request_id']
    request.body.rewind
    request_body = request.body.read
    validation = Validation.new(request_body)
    validation.validate_req_data
    if validation.valid?
      # values_1 = request_body['data'].first['values']
      # values_2 = request_body['data'].last['values']
      # result_json = {
      #   request_id: request_id,
      #   timestamp: request_body['timestamp'],
      #   result: {
      #     title: 'Result',
      #     values: values_1.zip(values_2).map { |x, y| x - y }
      #   }
      # }.to_json
    else
      content_type :json
      status 400
      result_json = {:result => 'Error', :message => validation.formatted_errors}.to_json
    end
    result_json
  end
end
