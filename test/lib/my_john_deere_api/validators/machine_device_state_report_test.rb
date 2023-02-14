require 'support/helper'

class MachineDeviceStateReportValidatorTest
  include JD::Validators::MachineDeviceStateReport

  attr_reader :attributes

  def initialize(attributes)
    @attributes = attributes
  end
end

describe 'MyJohnDeereApi::Validators::MachineDeviceStateReport' do
  let(:klass) { MachineDeviceStateReportValidatorTest }
  let(:object) { klass.new(attributes) }
  let(:attributes) { valid_attributes }

  let(:valid_attributes) do
    {
      machine_id: machine_id,
      time: '2023-01-31T06:18:03.000Z',
      location: {
        '@type': 'Point',
        lat: 42.45613888888889,
        lon: -71.73694444444445,
        altitude: {
          '@type': 'measurementAsDouble',
          valueAsDouble: 0.0,
          unit: 'meters'
        }
      },
      gps_fix_timestamp: '2020-02-10T11:29:32.000Z'
    }
  end

  it 'exists' do
    assert JD::Validators::MachineDeviceStateReport
  end

  it 'inherits from MyJohnDeereApi::Validators::Base' do
    [:validate!, :valid?].each{ |method_name| assert object.respond_to?(method_name) }
  end

  it 'requires several attributes' do
    [:machine_id, :time, :location, :gps_fix_timestamp].each do |attr|
      object = klass.new(valid_attributes.merge(attr => nil))

      refute object.valid?
      exception = assert_raises(JD::InvalidRecordError) { object.validate! }

      assert_includes exception.message, "#{attr} is required"
      assert_includes object.errors[attr], 'is required'
    end
  end
end
