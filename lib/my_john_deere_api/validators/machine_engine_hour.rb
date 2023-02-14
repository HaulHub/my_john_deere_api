module MyJohnDeereApi::Validators
  module MachineEngineHour
    include Base

    private

    def required_attributes
      [:machine_id, :reading, :report_time]
    end

    ##
    # Custom validations for this class

    def validate_attributes
      validate_reading_data
    end

    def validate_reading_data
      unless attributes[:reading].is_a?(Hash)
        errors[:reading] ||= 'must be an hash'
        return
      end

      [:@type, :valueAsDouble, :unit].each do |attr|
        unless attributes[:reading].has_key?(attr)
          errors[:reading] ||= "must include #{attr}"
          return
        end
      end
    end
  end
end
