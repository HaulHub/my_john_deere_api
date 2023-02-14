require 'support/helper'

describe 'MyJohnDeereApi::Model::Machine' do
  include JD::ResponseHelpers
  include JD::LinkHelpers

  let(:klass) { JD::Model::Machine }

  let(:record) do
    {
      "@type"=>"Machine",
      "GUID"=>"dd3c7b3f-4965-4115-81e3-251cc8c82a7e",
      "modelYear"=>"2023",
      "id"=>machine_id,
      "vin"=>"Happy Machine",
      "name"=>"Happy Machine",
      "links"=>[
        {"@type"=>"Link", "rel"=>"self", "uri"=>"https://sandboxapi.deere.com/platform/machines/#{machine_id}"},
        {"@type"=>"Link", "rel"=>"organizations", "uri"=>"https://sandboxapi.deere.com/platform/organizations/#{organization_id}"},
        {"@type"=>"Link", "rel"=>"alerts", "uri"=>"https://sandboxapi.deere.com/platform/machines/#{machine_id}/alerts"},
        {"@type"=>"Link", "rel"=>"hoursOfOperation", "uri"=>"https://sandboxapi.deere.com/platform/machines/#{machine_id}/hoursOfOperation"},
        {"@type"=>"Link", "rel"=>"deviceStateReports", "uri"=>"https://sandboxapi.deere.com/platform/machines/#{machine_id}/deviceStateReports"},
        {"@type"=>"Link", "rel"=>"engineHours", "uri"=>"https://sandboxapi.deere.com/platform/machines/#{machine_id}/engineHours"},
        {"@type"=>"Link", "rel"=>"locationHistory", "uri"=>"https://sandboxapi.deere.com/platform/machines/#{machine_id}/locationHistory"},
        {"@type"=>"Link", "rel"=>"breadcrumbs", "uri"=>"https://sandboxapi.deere.com/platform/machines/#{machine_id}/breadcrumbs"},
        {"@type"=>"Link", "rel"=>"capabilities", "uri"=>"https://sandboxapi.deere.com/platform/machines/#{machine_id}/capabilities"}
      ]
    }
  end

  describe '#initialize' do
    it 'sets the attributes from the given record' do
      machine = klass.new(client, record)

      assert_equal client, machine.client
      assert_equal accessor, machine.accessor

      # basic attributes
      assert_equal record['id'], machine.id
      assert_equal record['vin'], machine.vin
      assert_equal record['name'], machine.name
      assert_equal record['category'], machine.category
      assert_equal record['make'], machine.make
      assert_equal record['model'], machine.model

      # links to other things
      assert_kind_of Hash, machine.links

      [
        'self', 'organizations', 'alerts', 'hours_of_operation',
        'device_state_reports', 'engine_hours', 'location_history',
        'breadcrumbs', 'capabilities'
      ].each do |association|
        assert_link_for(machine, association)
      end
    end
  end

  describe '#attributes' do
    it 'converts properties back to an attributes hash' do
      machine = klass.new(client, record)
      attributes = machine.attributes

      assert_equal machine.id, attributes[:id]
      assert_equal machine.vin, attributes[:vin]
      assert_equal machine.name, attributes[:name]
    end
  end

  describe '#device_state_reports' do
    it 'returns a collection of device state reports for this machine' do
      organization = VCR.use_cassette('get_organizations') { client.organizations.first }
      machine = VCR.use_cassette('get_machines') { organization.machines.first }

      device_state_reports = VCR.use_cassette('get_machine_device_state_reports') do
        machine.device_state_reports.all
        machine.device_state_reports
      end

      assert_kind_of Array, device_state_reports.all

      device_state_reports.each do |device_state_report|
        assert_kind_of JD::Model::MachineDeviceStateReport, device_state_report
      end
    end
  end

  describe '#engine_hours' do
    it 'returns a collection of engine hours for this machine' do
      organization = VCR.use_cassette('get_organizations') { client.organizations.first }
      machine = VCR.use_cassette('get_machines') { organization.machines.first }

      engine_hours = VCR.use_cassette('get_machine_engine_hours') do
        machine.engine_hours.all
        machine.engine_hours
      end

      assert_kind_of Array, engine_hours.all

      engine_hours.each do |engine_hour|
        assert_kind_of JD::Model::MachineEngineHour, engine_hour
      end
    end
  end

  describe '#hours_of_operation' do
    it 'returns a collection of hours of operation for this machine' do
      organization = VCR.use_cassette('get_organizations') { client.organizations.first }
      machine = VCR.use_cassette('get_machines') { organization.machines.first }

      hours_of_operation = VCR.use_cassette('get_machine_hours_of_operation') do
        machine.hours_of_operation.all
        machine.hours_of_operation
      end

      assert_kind_of Array, hours_of_operation.all

      hours_of_operation.each do |hours_of_operation|
        assert_kind_of JD::Model::MachineHoursOfOperation, hours_of_operation
      end
    end
  end

  describe '#breadcrumbs' do
    it 'returns a collection of breadcrumbs for this machine' do
      organization = VCR.use_cassette('get_organizations') { client.organizations.first }
      machine = VCR.use_cassette('get_machines') { organization.machines.first }

      breadcrumbs = VCR.use_cassette('get_machine_breadcrumbs') do
        machine.breadcrumbs.all
        machine.breadcrumbs
      end

      assert_kind_of Array, breadcrumbs.all

      breadcrumbs.each do |breadcrumb|
        assert_kind_of JD::Model::MachineBreadcrumb, breadcrumb
      end
    end
  end
end
