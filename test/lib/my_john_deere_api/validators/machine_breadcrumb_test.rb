require 'support/helper'

class MachineBreadcrumbValidatorTest
  include JD::Validators::MachineBreadcrumb

  attr_reader :attributes

  def initialize(attributes)
    @attributes = attributes
  end
end

describe 'MyJohnDeereApi::Validators::MachineBreadcrumb' do
  let(:klass) { MachineBreadcrumbValidatorTest }
  let(:object) { klass.new(attributes) }
  let(:attributes) { valid_attributes }

  let(:valid_attributes) do
    {
      machine_id: machine_id,
      speed: {
        '@type': 'measurementAsDouble',
        valueAsDouble: 0.0,
        unit: 'km1hr-1'
      },
      heading: {
        '@type': 'measurementAsInteger',
        valueAsInteger: '64'
      },
      machine_state: {
        '@type': 'Breadcrumb$MachineState',
        rawState: 0
      },
      fuel_level: {
        '@type': 'measurementAsDouble',
        valueAsDouble: 75.6,
        unit: 'prcnt'
      },
      point: {
        '@type': 'Point',
        lat: 42.45613888888889,
        lon: -71.73694444444445
      },
      event_timestamp: '2023-01-26T19:19:16.000Z'
    }
  end

  it 'exists' do
    assert JD::Validators::MachineBreadcrumb
  end

  it 'inherits from MyJohnDeereApi::Validators::Base' do
    [:validate!, :valid?].each{ |method_name| assert object.respond_to?(method_name) }
  end

  it 'requires several attributes' do
    [:speed, :heading, :machine_state, :fuel_level, :point, :event_timestamp].each do |attr|
      object = klass.new(valid_attributes.merge(attr => nil))

      refute object.valid?
      exception = assert_raises(JD::InvalidRecordError) { object.validate! }

      assert_includes exception.message, "#{attr} is required"
      assert_includes object.errors[attr], 'is required'
    end
  end
end
