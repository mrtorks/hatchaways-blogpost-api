require "rails_helper"

RSpec.describe Api::PostsController, type: :routing do
  describe "routing" do
    puts '--------------------------------------------------------------------'
    puts 'Begin Post Route Test......'
    puts '--------------------------------------------------------------------'
    it "routes to #index" do
      expect(get: api_posts_path).to route_to("api/posts#index")
      expect(get: '/posts').not_to be_routable
      expect(get: 'api/posts').to be_routable
    end
  end
end
