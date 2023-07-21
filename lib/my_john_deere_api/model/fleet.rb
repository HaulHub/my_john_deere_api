require 'uri'

module MyJohnDeereApi
  class Model::Fleet < Model::Base
    attr_reader :equipment, :location, :cumulative_idle_hours,
      :cumulative_operating_hours, :fuel_remaining, :fuel_used

    private

    def map_attributes(record)
      @equipment = record['EquipmentHeader']
      @location = record['Location']
      @cumulative_idle_hours = record['CumulativeIdleHours']
      @cumulative_operating_hours = record['CumulativeOperatingHours']
      @fuel_remaining = record['FuelRemaining']
      @fuel_used = record['FuelUsed']

      # hack to work with existing JSON implementation
      record['links'] = []
    end

    def expected_record_type
    end
  end
end
