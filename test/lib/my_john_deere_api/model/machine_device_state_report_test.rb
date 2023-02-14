require 'support/helper'

describe 'MyJohnDeereApi::Model::MachineDeviceStateReport' do
  include JD::ResponseHelpers
  include JD::LinkHelpers

  let(:klass) { JD::Model::MachineDeviceStateReport }

  let(:record) do
    {
      "@type"=>"DeviceStateReport",
      "time"=>"2023-01-31T06:18:03.000Z",
      "location"=>{"@type"=>"Point", "lat"=>42.45613888888889, "lon"=>-71.73694444444445, "altitude"=>{"@type"=>"measurementAsDouble", "valueAsDouble"=>0.0, "unit"=>"meters"}},
      "gpsFixTimestamp"=>"2023-01-26T19:19:16.000Z",
      "links"=>[
        {"rel"=>"self", "uri"=>"https://sandboxapi.deere.com/platform/machines/#{machine_id}/deviceStateReports"}
      ]
    }
  end

  describe '#initialize' do
    it 'sets the attributes from the given record' do
      machine = klass.new(client, record)

      assert_equal client, machine.client
      assert_equal accessor, machine.accessor

      # basic attributes
      assert_equal record['time'], machine.time
      assert_equal record['location'], machine.location
      assert_equal record['gpsFixTimestamp'], machine.gps_fix_timestamp
      assert_equal record['engineState'], machine.engine_state

      # links to other things
      assert_kind_of Hash, machine.links
      assert_link_for(machine, 'self')
    end
  end
end
