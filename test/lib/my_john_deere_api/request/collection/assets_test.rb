require 'support/helper'
require 'yaml'
require 'json'

describe 'MyJohnDeereApi::Request::Collection::Fields' do
  let(:organization_id) do
    contents = File.read('test/support/vcr/get_organizations.yml')
    body = YAML.load(contents)['http_interactions'].first['response']['body']['string']
    JSON.parse(body)['values'].first['id']
  end

  let(:client) { JD::Client.new(API_KEY, API_SECRET, environment: :sandbox, access: [ACCESS_TOKEN, ACCESS_SECRET]) }
  let(:accessor) { VCR.use_cassette('catalog') { client.send(:accessor) } }
  let(:collection) { JD::Request::Collection::Assets.new(accessor, organization: organization_id) }

  describe '#initialize(access_token)' do
    it 'accepts an access token' do
      assert_kind_of OAuth::AccessToken, collection.accessor
    end

    it 'accepts associations' do
      collection = JD::Request::Collection::Assets.new(accessor, organization: '123')

      assert_kind_of Hash, collection.associations
      assert_equal '123', collection.associations[:organization]
    end
  end

  describe '#resource' do
    it 'returns /organizations/{org_id}/assets' do
      assert_equal "/organizations/#{organization_id}/assets", collection.resource
    end
  end

  describe '#all' do
    it 'returns all records' do
      all = VCR.use_cassette('get_assets', record: :new_episodes) { collection.all }

      assert_kind_of Array, all
      assert_equal collection.count, all.size

      all.each do |item|
        assert_kind_of JD::Model::Asset, item
      end
    end
  end

  describe '#count' do
    let(:server_response) do
      contents = File.read('test/support/vcr/get_assets.yml')
      body = YAML.load(contents)['http_interactions'].first['response']['body']['string']
      JSON.parse(body)
    end

    let(:server_count) { server_response['total'] }

    it 'returns the total count of records in the collection' do
      count = VCR.use_cassette('get_assets') { collection.count }

      assert_equal server_count, count
    end
  end

  describe 'results' do
    let(:asset_titles) do
      contents = File.read('test/support/vcr/get_assets.yml')
      body = YAML.load(contents)['http_interactions'].first['response']['body']['string']
      JSON.parse(body)['values'].map{|v| v['title']}
    end

    it 'returns all records as a single enumerator' do
      count = VCR.use_cassette('get_assets') { collection.count }
      titles = VCR.use_cassette('get_assets', record: :new_episodes) { collection.map(&:title) }

      assert_kind_of Array, titles
      assert_equal count, titles.size

      asset_titles.each do |expected_title|
        assert_includes titles, expected_title
      end
    end
  end
end