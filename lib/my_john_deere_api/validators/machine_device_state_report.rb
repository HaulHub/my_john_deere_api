module MyJohnDeereApi::Validators
  module MachineDeviceStateReport
    include Base

    private

    def required_attributes
      [:machine_id, :time, :location, :gps_fix_timestamp]
    end

    ##
    # Custom validations for this class

    def validate_attributes
      validate_location_data
    end

    def validate_location_data
      unless attributes[:location].is_a?(Hash)
        errors[:location] ||= 'must be an hash'
        return
      end

      [:@type, :lat, :lon, :altitude].each do |attr|
        unless attributes[:location].has_key?(attr)
          errors[:location] ||= "must include #{attr}"
          return
        end
      end
    end
  end
end
