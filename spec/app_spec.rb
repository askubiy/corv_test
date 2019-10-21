require 'spec_helper'

describe CorvaTestApp do
  let(:c_type) { {'CONTENT_TYPE' => 'application/json'} }

  let(:miss_p_2) {
    {
      :data => [
        { title: "Part 1" }
      ],
      :timestamp => Time.now.to_i
    }.to_json
  }

  let(:miss_p_v1) {
    {
      :data => [
        { title: "Part 1" },
        { title: "Part 2" }
      ],
      :timestamp => Time.now.to_i
    }.to_json
  }

  let(:miss_p_v2) {
    {
      :data => [
        { title: "Part 1", values: [0, 3, 5, 6, 2, 9] },
        { title: "Part 2" }
      ],
      :timestamp => Time.now.to_i
    }.to_json
  }

  let(:val_1_not_array) {
    {
      :data => [
        { title: "Part 1", values: "not_an_array" },
        { title: "Part 2", values: [0, 3, 5, 6, 2, 9] }
      ],
      :timestamp => Time.now.to_i
    }.to_json
  }

  let(:length_mismatch) {
    {
      :data => [
        { title: "Part 1", values: [0, 3, 5] },
        { title: "Part 2", values: [0, 3, 5, 6, 2, 9] }
      ],
      :timestamp => Time.now.to_i
    }.to_json
  }

  let(:valid_body) {
    {
      :data => [
        { title: "Part 1", values: [0, 3, 5, 6, 2, 9] },
        { title: "Part 2", values: [6, 3, 1, 3, 9, 4] }
      ],
      :timestamp => 1493758596
    }.to_json
  }

  it 'should return a 400 Bad Request for GET requests' do
    get '/'
    expect(last_response.status).to eq(400)
  end

  it 'should return JSON validation error if request body is not valid JSON' do
    post '/compute/sample-req001', "whatever"
    expect(last_response.status).to eq(400)
    expect(last_response.body).to eq({ "result": "Error", "message": "JSON parse error" }.to_json)
  end

  it 'should return Missed required property error if request body is not valid JSON' do
    post '/compute/sample-req001', { :data => "[]" }.to_json, c_type
    expect(last_response.status).to eq(400)
    expect(last_response.body).to eq({
      "result": "Error", "message": "Missed required property: timestamp"
    }.to_json)
  end

  it 'should return Missed required items error if request data is not valid' do
    post '/compute/sample-req001', { :data => [], :timestamp => Time.now.to_i }.to_json, c_type
    expect(last_response.status).to eq(400)
    expect(last_response.body).to eq({
      "result": "Error", "message": "Missed Part 1 item in data"
    }.to_json)

    post '/compute/sample-req001', miss_p_2, c_type
    expect(last_response.status).to eq(400)
    expect(last_response.body).to eq({
      "result": "Error", "message": "Missed Part 2 item in data"
    }.to_json)

    post '/compute/sample-req001', miss_p_v1, c_type
    expect(last_response.status).to eq(400)
    expect(last_response.body).to eq({
      "result": "Error", "message": "Missed Part 1 values in data"
    }.to_json)

    post '/compute/sample-req001', miss_p_v2, c_type
    expect(last_response.status).to eq(400)
    expect(last_response.body).to eq({
      "result": "Error", "message": "Missed Part 2 values in data"
    }.to_json)

    post '/compute/sample-req001', val_1_not_array, c_type
    expect(last_response.status).to eq(400)
    expect(last_response.body).to eq({
      "result": "Error", "message": "Wrong type of values"
    }.to_json)

    post '/compute/sample-req001', length_mismatch, c_type
    expect(last_response.status).to eq(400)
    expect(last_response.body).to eq({
      "result": "Error", "message": "Value arrays length mismatch"
    }.to_json)
  end

  it 'should return correct response when request body is valid' do
    post '/compute/sample-req001', valid_body, c_type
    expect(last_response.status).to eq(200)
    expect(last_response.body).to eq({
      "request_id": "sample-req001",
      "timestamp": 1493758596,
      "result": {
        "title": "Result",
        "values":[-6,0,4,3,-7,5]
      }
    }.to_json)
  end
end
