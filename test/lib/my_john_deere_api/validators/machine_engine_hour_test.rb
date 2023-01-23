require 'support/helper'

class MachineEngineHourValidatorTest
  include JD::Validators::MachineEngineHour

  attr_reader :attributes

  def initialize(attributes)
    @attributes = attributes
  end
end

describe 'MyJohnDeereApi::Validators::MachineEngineHour' do
  let(:klass) { MachineEngineHourValidatorTest }
  let(:object) { klass.new(attributes) }
  let(:attributes) { valid_attributes }

  let(:valid_attributes) do
    {
      machine_id: machine_id,
      reading: {
        '@type': 'measurementAsDouble',
        valueAsDouble: 2.7,
        unit: 'Hours'
      },
      report_time: '2020-02-10T11:29:32.000Z'
    }
  end

  it 'exists' do
    assert JD::Validators::MachineEngineHour
  end

  it 'inherits from MyJohnDeereApi::Validators::Base' do
    [:validate!, :valid?].each{ |method_name| assert object.respond_to?(method_name) }
  end

  it 'requires several attributes' do
    [:machine_id, :reading, :report_time].each do |attr|
      object = klass.new(valid_attributes.merge(attr => nil))

      refute object.valid?
      exception = assert_raises(JD::InvalidRecordError) { object.validate! }

      assert_includes exception.message, "#{attr} is required"
      assert_includes object.errors[attr], 'is required'
    end
  end
end
