require 'support/helper'

describe 'MyJohnDeereApi::Model::MachineHoursOfOperation' do
  include JD::ResponseHelpers
  include JD::LinkHelpers

  let(:klass) { JD::Model::MachineHoursOfOperation }

  let(:record) do
    {
      "@type"=>"HoursOfOperation",
      "startDate"=>"2023-01-02T17:13:04.000Z",
      "endDate"=>"2023-01-02T18:13:04.000Z",
      "engineState"=>0,
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
      assert_equal record['startDate'], machine.start_date
      assert_equal record['endDate'], machine.end_date
      assert_equal record['engineState'], machine.engine_state

      # links to other things
      assert_kind_of Hash, machine.links
      assert_link_for(machine, 'machine')
    end
  end
end
