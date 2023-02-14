require 'support/helper'
require 'yaml'
require 'json'

describe 'MyJohnDeereApi::Request::Collection::Machines' do
  let(:klass) { JD::Request::Collection::Machines }
  let(:collection) { klass.new(client, organization: organization_id) }
  let(:object) { collection }

  inherits_from JD::Request::Collection::Base

  describe '#initialize(client)' do
    it 'accepts a client' do
      assert_equal client, collection.client
    end

    it 'accepts associations' do
      collection = klass.new(client, organization: organization_id)

      assert_kind_of Hash, collection.associations
      assert_equal organization_id, collection.associations[:organization]
    end
  end

   describe '#resource' do
    it 'returns /platform/organizations/{org_id}/machines' do
      assert_equal "/platform/organizations/#{organization_id}/machines", collection.resource
    end
  end

   describe '#all' do
     it 'returns all records' do
       all = VCR.use_cassette('get_machines') { collection.all }

       assert_kind_of Array, all
       assert_equal collection.count, all.size

       all.each do |item|
         assert_kind_of JD::Model::Machine, item
       end
     end
   end

   describe '#find(machine_id)' do
     it 'retrieves the machine' do
       machine = VCR.use_cassette('get_machine') { collection.find(machine_id) }
       assert_kind_of JD::Model::Machine, machine
     end
   end

   describe '#count' do
     let(:server_response) do
       contents = File.read('test/support/vcr/get_machines.yml')
       body = YAML.load(contents)['http_interactions'].last['response']['body']['string']
       JSON.parse(body)
     end

     let(:server_count) { server_response['total'] }

     it 'returns the total count of records in the collection' do
       count = VCR.use_cassette('get_machines') { collection.count }

       assert_equal server_count, count
     end
   end

   describe 'results' do
     let(:machine_names) do
       contents = File.read('test/support/vcr/get_machines.yml')
       body = YAML.load(contents)['http_interactions'].last['response']['body']['string']
       JSON.parse(body)['values'].map{|v| v['name']}
     end

     it 'returns all records as a single enumerator' do
       count = VCR.use_cassette('get_machines') { collection.count }
       titles = VCR.use_cassette('get_machines') { collection.map(&:name) }

       assert_kind_of Array, titles
       assert_equal count, titles.size

       machine_names.each do |expected_title|
         assert_includes titles, expected_title
       end
     end
   end
end
