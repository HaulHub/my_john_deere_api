require 'support/helper'

class MachineValidatorTest
  include JD::Validators::Machine

  attr_reader :attributes

  def initialize(attributes)
    @attributes = attributes
  end
end

describe 'MyJohnDeereApi::Validators::Asset' do
  let(:klass) { MachineValidatorTest }
  let(:object) { klass.new(attributes) }
  let(:attributes) { valid_attributes }

  let(:valid_attributes) do
    {
      machine_id: '000000',
      vin: "Bob's Machine",
      name: "Bob's Machine"
    }
  end

  it 'exists' do
    assert JD::Validators::Machine
  end

  it 'inherits from MyJohnDeereApi::Validators::Base' do
    [:validate!, :valid?].each{ |method_name| assert object.respond_to?(method_name) }
  end

  it 'requires several attributes' do
    [:machine_id, :vin, :name].each do |attr|
      object = klass.new(valid_attributes.merge(attr => nil))

      refute object.valid?
      exception = assert_raises(JD::InvalidRecordError) { object.validate! }

      assert_includes exception.message, "#{attr} is required"
      assert_includes object.errors[attr], 'is required'
    end
  end
end
