require 'support/helper'
require 'yaml'
require 'json'

describe 'MyJohnDeereApi::Request::Collection::MachineDeviceStateReports' do
  let(:klass) { JD::Request::Collection::MachineDeviceStateReports }
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
    it 'returns /platform/machines/{machine_id}/deviceStateReports' do
      assert_equal "/platform/machines/#{machine_id}/deviceStateReports?lastKnown=", collection.resource
    end
  end

   describe '#all' do
     it 'returns all records' do
       all = VCR.use_cassette('get_machine_device_state_reports') { collection.all }

       assert_kind_of Array, all
       assert_equal collection.count, all.size

       all.each do |item|
         assert_kind_of JD::Model::MachineDeviceStateReport, item
       end
     end
   end

   describe '#count' do
     let(:server_response) do
       contents = File.read('test/support/vcr/get_machine_device_state_reports.yml')
       body = YAML.load(contents)['http_interactions'].last['response']['body']['string']
       JSON.parse(body)
     end

     let(:server_count) { server_response['total'] }

     it 'returns the total count of records in the collection' do
       count = VCR.use_cassette('get_machine_device_state_reports') { collection.count }

       assert_equal server_count, count
     end
   end

   describe 'results' do
     let(:machine_device_state_report_locations) do
       contents = File.read('test/support/vcr/get_machine_device_state_reports.yml')
       body = YAML.load(contents)['http_interactions'].last['response']['body']['string']
       JSON.parse(body)['values'].map{|v| v['location']}
     end

     it 'returns all records as a single enumerator' do
       count = VCR.use_cassette('get_machine_device_state_reports') { collection.count }
       locations = VCR.use_cassette('get_machine_device_state_reports') { collection.map(&:location) }

       assert_kind_of Array, locations
       assert_equal count, locations.size

       machine_device_state_report_locations.each do |expected_location|
         assert_includes locations, expected_location
       end
     end
   end
end
