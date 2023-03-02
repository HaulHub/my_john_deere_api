require 'support/helper'

class MachineLocationHistoryValidatorTest
  include JD::Validators::MachineLocationHistory

  attr_reader :attributes

  def initialize(attributes)
    @attributes = attributes
  end
end

describe 'MyJohnDeereApi::Validators::MachineLocationHistory' do
  let(:klass) { MachineLocationHistoryValidatorTest }
  let(:object) { klass.new(attributes) }
  let(:attributes) { valid_attributes }

  let(:valid_attributes) do
    {
      machine_id: machine_id,
      point: {
        '@type': 'Point',
        lat: 42.45613888888889,
        lon: -71.73694444444445
      },
      event_timestamp: '2023-01-26T19:19:16.000Z',
      gps_fix_timestamp: '2023-02-26T13:44:14.000Z'
    }
  end

  it 'exists' do
    assert JD::Validators::MachineLocationHistory
  end

  it 'inherits from MyJohnDeereApi::Validators::Base' do
    [:validate!, :valid?].each{ |method_name| assert object.respond_to?(method_name) }
  end

  it 'requires several attributes' do
    [:point, :event_timestamp, :gps_fix_timestamp].each do |attr|
      object = klass.new(valid_attributes.merge(attr => nil))

      refute object.valid?
      exception = assert_raises(JD::InvalidRecordError) { object.validate! }

      assert_includes exception.message, "#{attr} is required"
      assert_includes object.errors[attr], 'is required'
    end
  end
end
