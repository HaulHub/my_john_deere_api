module MyJohnDeereApi::Validators
  module MachineHoursOfOperation
    include Base

    private

    def required_attributes
      [:machine_id, :start_date, :end_date, :engine_state]
    end

  end
end
