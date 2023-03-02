require 'support/helper'

describe 'MyJohnDeereApi::Model::MachineLocationHistory' do
  include JD::ResponseHelpers
  include JD::LinkHelpers

  let(:klass) { JD::Model::MachineLocationHistory }

  let(:record) do
    {
      "@type"=>"ReportedLocation",
      "point"=>{"@type"=>"Point", "lat"=>42.45613888888889, "lon"=>-71.73694444444445},
      "eventTimestamp"=>"2023-02-26T13:44:14.000Z",
      "gpsFixTimestamp"=>"2023-02-26T13:44:14.000Z",
      "links"=>[
        {"@type"=>"Link", "rel"=>"machine", "uri"=>"https://sandboxapi.deere.com/platform/machines/#{machine_id}"}
      ]
    }
  end

  describe '#initialize' do
    it 'sets the attributes from the given record' do
      machine = klass.new(client, record)

      assert_equal client, machine.client
      assert_equal accessor, machine.accessor

      # basic attributes
      assert_equal record['point'], machine.point
      assert_equal record['eventTimestamp'], machine.event_timestamp
      assert_equal record['gpsFixTimestamp'], machine.event_timestamp

      # links to other things
      assert_kind_of Hash, machine.links
      assert_link_for(machine, 'machine')
    end
  end
end
