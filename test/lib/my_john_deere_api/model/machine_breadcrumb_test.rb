require 'support/helper'

describe 'MyJohnDeereApi::Model::MachineBreadcrumb' do
  include JD::ResponseHelpers
  include JD::LinkHelpers

  let(:klass) { JD::Model::MachineBreadcrumb }

  let(:record) do
    {
      "@type"=>"Breadcrumb",
      "createTimestamp"=>"2023-01-31T06:18:19.496Z",
      "speed"=>{"@type"=>"measurementAsDouble", "valueAsDouble"=>0.0, "unit"=>"km1hr-1"},
      "heading"=>{"@type"=>"measurementAsInteger", "valueAsInteger"=>"64"},
      "machineState"=>{"@type"=>"Breadcrumb$MachineState", "rawState"=>0},
      "fuelLevel"=>{"@type"=>"measurementAsDouble", "valueAsDouble"=>75.6, "unit"=>"prcnt"},
      "origin"=>"BREADCRUMB",
      "point"=>{"@type"=>"Point", "lat"=>42.45613888888889, "lon"=>-71.73694444444445},
      "eventTimestamp"=>"2023-01-26T19:19:16.000Z",
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
      assert_equal record['speed'], machine.speed
      assert_equal record['heading'], machine.heading
      assert_equal record['machineState'], machine.machine_state
      assert_equal record['fuelLevel'], machine.fuel_level
      assert_equal record['point'], machine.point
      assert_equal record['eventTimestamp'], machine.event_timestamp

      # links to other things
      assert_kind_of Hash, machine.links
      assert_link_for(machine, 'machine')
    end
  end
end
