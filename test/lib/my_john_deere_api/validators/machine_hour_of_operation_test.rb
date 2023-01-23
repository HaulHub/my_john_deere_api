require 'support/helper'

class MachineHoursOfOperationValidatorTest
  include JD::Validators::MachineHoursOfOperation

  attr_reader :attributes

  def initialize(attributes)
    @attributes = attributes
  end
end

describe 'MyJohnDeereApi::Validators::MachineBreadcrumb' do
  let(:klass) { MachineHoursOfOperationValidatorTest }
  let(:object) { klass.new(attributes) }
  let(:attributes) { valid_attributes }

  let(:valid_attributes) do
    {
      machine_id: machine_id,
      startDate: '2023-01-02T17:13:04.000Z',
      endDate: '2023-01-02T18:13:04.000Z',
      engineState: 0,
    }
  end

  it 'exists' do
    assert JD::Validators::MachineHoursOfOperation
  end

  it 'inherits from MyJohnDeereApi::Validators::Base' do
    [:validate!, :valid?].each{ |method_name| assert object.respond_to?(method_name) }
  end

  it 'requires several attributes' do
    [:start_date, :end_date, :engine_state].each do |attr|
      object = klass.new(valid_attributes.merge(attr => nil))

      refute object.valid?
      exception = assert_raises(JD::InvalidRecordError) { object.validate! }

      assert_includes exception.message, "#{attr} is required"
      assert_includes object.errors[attr], 'is required'
    end
  end
end
