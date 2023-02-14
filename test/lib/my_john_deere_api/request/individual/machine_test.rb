require 'support/helper'
require 'yaml'
require 'json'

describe 'MyJohnDeereApi::Request::Individual::Machine' do
  let(:object) { JD::Request::Individual::Machine.new(client, machine_id) }

  inherits_from JD::Request::Individual::Base

  describe '#initialize(client, machine_id)' do
    it 'accepts a client' do
      assert_equal client, object.client
    end

    it 'accepts machine_id as id' do
      assert_equal machine_id, object.id
    end
  end

  describe '#resource' do
    it 'returns /platform/machines/<machine_id>' do
      assert_equal "/platform/machines/#{machine_id}", object.resource
    end
  end

  describe '#object' do
    it 'returns all records' do
      machine = VCR.use_cassette('get_machine') { object.object }
      assert_kind_of JD::Model::Machine, machine
    end
  end
end
