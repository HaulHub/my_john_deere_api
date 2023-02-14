module MyJohnDeereApi::Validators
  module MachineBreadcrumb
    include Base

    private

    def required_attributes
      [:machine_id, :speed, :heading, :machine_state, :fuel_level, :point, :event_timestamp]
    end

    ##
    # Custom validations for this class

    def validate_attributes
      validate_speed_data
      validate_heading_data
      validate_machine_state_data
      validate_fuel_level_data
      validate_point_data
    end

    def validate_speed_data
      unless attributes[:speed].is_a?(Hash)
        errors[:speed] ||= 'must be an hash'
        return
      end

      [:@type, :valueAsDouble, :unit].each do |attr|
        unless attributes[:speed].has_key?(attr)
          errors[:speed] ||= "must include #{attr}"
          return
        end
      end
    end

    def validate_heading_data
      unless attributes[:heading].is_a?(Hash)
        errors[:heading] ||= 'must be an hash'
        return
      end

      [:@type, :valueAsInteger].each do |attr|
        unless attributes[:heading].has_key?(attr)
          errors[:heading] ||= "must include #{attr}"
          return
        end
      end
    end

    def validate_machine_state_data
      unless attributes[:machine_state].is_a?(Hash)
        errors[:machine_state] ||= 'must be an hash'
        return
      end

      [:@type, :rawState].each do |attr|
        unless attributes[:machine_state].has_key?(attr)
          errors[:machine_state] ||= "must include #{attr}"
          return
        end
      end
    end

    def validate_fuel_level_data
      unless attributes[:fuel_level].is_a?(Hash)
        errors[:fuel_level] ||= 'must be an hash'
        return
      end

      [:@type, :valueAsDouble, :unit].each do |attr|
        unless attributes[:fuel_level].has_key?(attr)
          errors[:fuel_level] ||= "must include #{attr}"
          return
        end
      end
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
