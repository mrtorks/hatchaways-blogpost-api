# frozen_string_literal: true

module Api
  # show,update and destroy have been deleted to shed light on crtitcal method and to satisfy api requirements
  class PostsController < ApplicationController
    # GET /posts
    def index
      @posts = Post.process_data(post_params)
      render json: @posts, status: :ok
    rescue Post::DefaultError => e
      render json: { error: e.message}, status: :bad_request
    rescue Post::SortParamError => e
      render json: { error: e.message}, status: :bad_request
    rescue Post::DirectionError => e
      render json: { error: e.message}, status: :bad_request
    end

    private

    # Only allow a list of trusted parameters through.
    def post_params
      params.permit(:tags, :sortBy, :direction)
    end
  end
end
