require 'support/helper'

describe 'MyJohnDeereApi::Model::MachineEngineHour' do
  include JD::ResponseHelpers
  include JD::LinkHelpers

  let(:klass) { JD::Model::MachineEngineHour }

  let(:record) do
    {
      "@type"=>"EngineHours",
      "reading"=>{"@type"=>"measurementAsDouble", "valueAsDouble"=>2.7, "unit"=>"Hours"},
      "reportTime"=>"2023-01-31T06:18:03.000Z",
      "links"=>[
        {"rel"=>"self", "uri"=>"https://sandboxapi.deere.com/platform/machines/#{machine_id}/engineHours"}
      ]
    }
  end

  describe '#initialize' do
    it 'sets the attributes from the given record' do
      machine = klass.new(client, record)

      assert_equal client, machine.client
      assert_equal accessor, machine.accessor

      # basic attributes
      assert_equal record['reading'], machine.reading
      assert_equal record['reportTime'], machine.report_time

      # links to other things
      assert_kind_of Hash, machine.links
      assert_link_for(machine, 'self')
    end
  end
end
