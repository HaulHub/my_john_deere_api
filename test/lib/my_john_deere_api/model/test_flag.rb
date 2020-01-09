require 'support/helper'
require 'json'

describe 'MyJohnDeereApi::Model::Flag' do
  let(:record) do
    {
      "@type"=>"Flag",
      "geometry"=>"{\"type\": \"Point\", \"coordinates\": [-93.14959274063109, 41.66881548411553] }",
      "archived"=>true,
      "proximityAlertEnabled"=>true,
      "notes"=>"Our flag is a very, very, very nice flag!",
      "id"=>"123456",
      "links"=>[
        {"@type"=>"Link", "rel"=>"field", "uri"=>"https://sandboxapi.deere.com/platform/organizations/123456/fields/123456"},
        {"@type"=>"Link", "rel"=>"createdBy", "uri"=>"https://sandboxapi.deere.com/platform/users/bobsmith"},
        {"@type"=>"Link", "rel"=>"lastModifiedBy", "uri"=>"https://sandboxapi.deere.com/platform/users/jonsmith"},
      ]
    }
  end

  describe '#initialize' do
    def link_for label
      record['links'].detect{|link| link['rel'] == label}['uri'].gsub('https://sandboxapi.deere.com/platform', '')
    end

    it 'sets the attributes from the given record' do
      field = JD::Model::Flag.new(record)

      assert_nil field.accessor

      # basic attributes
      assert_equal JSON.parse(record['geometry']), field.geometry
      assert_equal record['archived'], field.archived?
      assert_equal record['proximityAlertEnabled'], field.proximity_alert_enabled?
      assert_equal record['notes'], field.notes
      assert_equal record['id'], field.id

      # links to other things
      assert_kind_of Hash, field.links
      assert_equal link_for('field'), field.links['field']
      assert_equal link_for('createdBy'), field.links['created_by']
      assert_equal link_for('lastModifiedBy'), field.links['last_modified_by']
    end

    it 'accepts an optional accessor' do
      accessor = 'mock-accessor'

      field = JD::Model::Flag.new(record, accessor)
      assert_equal accessor, field.accessor
    end
  end
end