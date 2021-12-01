require 'rails_helper'

RSpec.describe Post, type: :model do
    context 'raises exception' do
      it 'with no tag' do
        params = { 'tags'=>'' }
        expect{Post.process_data(params)}.to raise_error(Post::DefaultError, 'Tags parameter is required')
      end
    end

    context 'raises exception' do
      it 'with invalid sort params' do
        params = {'tags'=>'health', 'sortBy'=>'params'}
        expect{Post.process_data(params)}.to raise_error(Post::SortParamError, 'sortBy parameter is invalid')
      end
    end

    context 'raises exception' do
      it 'with invalid sort direction' do
        params = {'tags'=>'health', 'sortBy'=>'reads', 'direction'=>'up'}
        expect{Post.process_data(params)}.to raise_error(Post::DirectionError, 'Direction parameter invalid. Please specify asc or desc')
      end
    end
  #no tests here as active record is not used
end
