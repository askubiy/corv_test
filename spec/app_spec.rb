require 'spec_helper'

describe CorvaTestApp do
  it 'should return a 400 Bad Request for GET requests' do
    get '/'
    expect(last_response.status).to eq(400)
  end

  it 'should return JSON validation error if request body is not valid JSON' do
    post '/compute/sample-req001', body: "whatever"
    expect(last_response.status).to eq(400)
    expect(last_response.body).to eq({  "result": "Error", "message": "JSON parse error" }.to_json)
  end
end
