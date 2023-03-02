module MyJohnDeereApi::Validators
  module MachineLocationHistory
    include Base

    private

    def required_attributes
      [:point, :event_timestamp, :gps_fix_timestamp]
    end

    ##
    # Custom validations for this class

    def validate_attributes
      validate_point_data
    end

    def validate_point_data
      unless attributes[:point].is_a?(Hash)
        errors[:point] ||= 'must be an hash'
        return
      end

      [:@type, :lat, :lon].each do |attr|
        unless attributes[:point].has_key?(attr)
          errors[:point] ||= "must include #{attr}"
          return
        end
      end
    end
  end
end
