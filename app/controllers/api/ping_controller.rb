# frozen_string_literal: true

module Api
  # show,update,private methods for action and destroy have been deleted to shed light on crtitcal method as well as satisfy api requirements
  class PingController < ApplicationController
    def index
      render json: { success: true }, status: :ok
    end
  end
end
