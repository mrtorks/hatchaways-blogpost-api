# frozen_string_literal: true

# Handling post api
class Post < ApplicationRecord
  # Error handler for tags params
  class DefaultError < ::StandardError
    def initialize(msg = 'Tags parameter is required')
      super(msg)
    end
  end

  # Error handler for direction params
  class DirectionError < ::StandardError
    def initialize(msg = 'Direction parameter invalid. Please specify asc or desc')
      super(msg)
    end
  end

  # Error handler for sortBy params
  class SortParamError < ::StandardError
    def initialize(msg = 'sortBy parameter is invalid')
      super(msg)
    end
  end

  # returns desired api structure
  def self.process_data(params)
    tags = params['tags']
    raise DefaultError if tags.nil? or tags.blank?

    sort_by = params['sortBy']
    direction = params['direction']
    allowed_sort_params = [nil, 'id', 'reads', 'likes', 'popularity']
    raise SortParamError unless sort_by.in? allowed_sort_params

    allowed_sort_directions = [nil, 'asc', 'desc']
    raise DirectionError unless direction.in? allowed_sort_directions

    tags_params = tags.split(',')
    tag1, tag2, tag3, tag4 = tags_params
    tag1_data, tag2_data, tag3_data, tag4_data = fetch_data(tag1, tag2, tag3, tag4)
    collect_results([tag2, tag3, tag4], [tag1_data, tag2_data, tag3_data, tag4_data], sort_by, direction)
  end

  # collect tag data in parallel
  def self.fetch_data(tag1, tag2, tag3, tag4)
    endpoint = ENV['API_URL']
    hydra = Typhoeus::Hydra.hydra
    prepared_tags = prepare_tags(tag1, tag2, tag3, tag4, endpoint)
    request1, request2, request3, request4 = prepared_tags
    hydra.queue(request1)
    tag2.nil? ? nil : hydra.queue(request2)
    tag3.nil? ? nil : hydra.queue(request3)
    tag4.nil? ? nil : hydra.queue(request4)
    hydra.run
    [request1, request2, request3, request4]
  end

  # prepare tag data for parallel execution
  def self.prepare_tags(tag1, tag2, tag3, tag4, endpoint)
    first_request = Typhoeus::Request.new("#{endpoint}#{tag1}")
    second_request = tag2.nil? ? nil : Typhoeus::Request.new("#{endpoint}#{tag2}", followlocation: true)
    third_request = tag3.nil? ? nil :  Typhoeus::Request.new("#{endpoint}#{tag3}", followlocation: true)
    last_request = tag4.nil? ? nil : Typhoeus::Request.new("#{endpoint}#{tag4}", followlocation: true)
    [first_request, second_request, third_request, last_request]
  end

  # return structured api results
  def self.collect_results(tag_params,data_arr,sort_by,direction)
    tag2, tag3, tag4 = tag_params
    tag1_data, tag2_data, tag3_data, tag4_data = data_arr
    first_response = JSON.parse(tag1_data.response.body)
    second_response = tag2.nil? ? nil : JSON.parse(tag2_data.response.body)
    third_response = tag3.nil? ? nil : JSON.parse(tag3_data.response.body)
    last_response = tag4.nil? ? nil : JSON.parse(tag4_data.response.body)
    collection = {}
    results = first_response.deeper_merge!(second_response).deeper_merge!(third_response).deeper_merge!(last_response)['posts'] if (sort_by.nil?)
    results = first_response.deeper_merge!(second_response).deeper_merge!(third_response).deeper_merge!(last_response)['posts'].reverse if (sort_by.nil? && direction == 'desc')
    results = first_response.deeper_merge!(second_response).deeper_merge!(third_response).deeper_merge!(last_response)['posts'].sort_by { |hash| hash[sort_by] } unless sort_by.blank?
    results = first_response.deeper_merge!(second_response).deeper_merge!(third_response).deeper_merge!(last_response)['posts'].sort_by { |hash| -hash[sort_by] } if (!sort_by.nil? && direction == 'desc')
    # Need one where sortby is not present and sorts by id in desc
    collection['posts'] = results
    collection
  end
end
