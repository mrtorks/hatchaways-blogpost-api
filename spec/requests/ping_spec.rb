require 'rails_helper'

RSpec.describe 'Pings', type: :request do

  describe 'GET /index' do
    puts '--------------------------------------------------------------------'
    puts 'Begin Ping Test......'
    puts '--------------------------------------------------------------------'
    it 'returns http 200 with message' do
      get api_ping_index_path
      expect(response.body).to eq('{"success":true}')
      expect(response).to have_http_status(:success)
      expect(response.header['Content-Type']).to eq('application/json; charset=utf-8')
      expect(JSON.parse(response.body)).to be_a Hash
    end

  end
end
