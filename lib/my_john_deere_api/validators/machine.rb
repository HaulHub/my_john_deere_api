module MyJohnDeereApi::Validators
  module Machine
    include Base

    private

    def required_attributes
      [:machine_id, :vin, :name]
    end

  end
end
