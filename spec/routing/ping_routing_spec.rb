require "rails_helper"

RSpec.describe Api::PingController, type: :routing do
  describe "routing" do
    puts '--------------------------------------------------------------------'
    puts 'Begin Ping Route Test......'
    puts '--------------------------------------------------------------------'
    it "routes to #index" do
      expect(get: api_ping_index_path).to route_to("api/ping#index")
      expect(get: '/ping').not_to be_routable
      expect(get: 'api/ping').to be_routable
    end
  end
end
