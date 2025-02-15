module MyJohnDeereApi::Request::Collection
  autoload :Base,                               'my_john_deere_api/request/collection/base'
  autoload :Machines,                           'my_john_deere_api/request/collection/machines'
  autoload :MachineEngineHours,                 'my_john_deere_api/request/collection/machine_engine_hours'
  autoload :MachineDeviceStateReports,          'my_john_deere_api/request/collection/machine_device_state_reports'
  autoload :MachineHoursOfOperation,            'my_john_deere_api/request/collection/machine_hours_of_operation'
  autoload :MachineBreadcrumbs,                 'my_john_deere_api/request/collection/machine_breadcrumbs'
  autoload :MachineLocationHistory,             'my_john_deere_api/request/collection/machine_location_history'
  autoload :Assets,                             'my_john_deere_api/request/collection/assets'
  autoload :AssetLocations,                     'my_john_deere_api/request/collection/asset_locations'
  autoload :ContributionProducts,               'my_john_deere_api/request/collection/contribution_products'
  autoload :ContributionDefinitions,            'my_john_deere_api/request/collection/contribution_definitions'
  autoload :Organizations,                      'my_john_deere_api/request/collection/organizations'
  autoload :Fields,                             'my_john_deere_api/request/collection/fields'
  autoload :Flags,                              'my_john_deere_api/request/collection/flags'
  autoload :Fleets,                             'my_john_deere_api/request/collection/fleets'
end
