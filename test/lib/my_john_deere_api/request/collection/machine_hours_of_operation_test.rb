require 'support/helper'
require 'yaml'
require 'json'

describe 'MyJohnDeereApi::Request::Collection::MachineHoursOfOperation' do
  let(:klass) { JD::Request::Collection::MachineHoursOfOperation }
  let(:collection) { klass.new(client, machine: machine_id) }
  let(:object) { collection }

  inherits_from JD::Request::Collection::Base

  describe '#initialize(client)' do
    it 'accepts a client' do
      assert_equal client, collection.client
    end

    it 'accepts associations' do
      collection = klass.new(client, machine: machine_id)

      assert_kind_of Hash, collection.associations
      assert_equal machine_id, collection.associations[:machine]
    end
  end

   describe '#resource' do
    it 'returns /platform/machines/{machine_id}/hoursOfOperation' do
      assert_equal "/platform/machines/#{machine_id}/hoursOfOperation?lastKnown=&startDate=", collection.resource
    end
  end

   describe '#all' do
     it 'returns all records' do
       all = VCR.use_cassette('get_machine_hours_of_operation') { collection.all }

       assert_kind_of Array, all
       assert_equal collection.count, all.size

       all.each do |item|
         assert_kind_of JD::Model::MachineHoursOfOperation, item
       end
     end
   end

   describe '#count' do
     let(:server_response) do
       contents = File.read('test/support/vcr/get_machine_hours_of_operation.yml')
       body = YAML.load(contents)['http_interactions'].last['response']['body']['string']
       JSON.parse(body)
     end

     let(:server_count) { server_response['total'] }

     it 'returns the total count of records in the collection' do
       count = VCR.use_cassette('get_machine_hours_of_operation') { collection.count }

       assert_equal server_count, count
     end
   end

   describe 'results' do
     let(:machine_hours_of_operation_engine_states) do
       contents = File.read('test/support/vcr/get_machine_hours_of_operation.yml')
       body = YAML.load(contents)['http_interactions'].last['response']['body']['string']
       JSON.parse(body)['values'].map{|v| v['engineState']}
     end

     it 'returns all records as a single enumerator' do
       count = VCR.use_cassette('get_machine_hours_of_operation') { collection.count }
       engine_states = VCR.use_cassette('get_machine_hours_of_operation') { collection.map(&:engine_state) }

       assert_kind_of Array, engine_states
       assert_equal count, engine_states.size

       machine_hours_of_operation_engine_states.each do |expected_engine_state|
         assert_includes engine_states, expected_engine_state
       end
     end
   end
end
