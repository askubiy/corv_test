require 'spec_helper'

describe CorvaTestApp do
  it 'should return a 400 Bad Request if url is wrong' do
    post '/'
    expect(last_response.status).to eq(400)
    get '/'
    expect(last_response.status).to eq(400)
  end
end
