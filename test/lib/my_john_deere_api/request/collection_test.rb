require 'support/helper'

describe 'MyJohnDeereApi::Request::Collection' do
  describe 'loading dependencies' do
    it 'loads Request::Collection::Base' do
      assert JD::Request::Collection::Base
    end

    it 'loads Request::Collection::Machines' do
      assert JD::Request::Collection::Machines
    end

    it 'loads Request::Collection::MachineEngineHours' do
      assert JD::Request::Collection::MachineEngineHours
    end

    it 'loads Request::Collection::MachineDeviceStateReports' do
      assert JD::Request::Collection::MachineDeviceStateReports
    end

    it 'loads Request::Collection::MachineHoursOfOperation' do
      assert JD::Request::Collection::MachineHoursOfOperation
    end

    it 'loads Request::Collection::MachineBreadcrumbs' do
      assert JD::Request::Collection::MachineBreadcrumbs
    end

    it 'loads Request::Collection::MachineLocationHistory' do
      assert JD::Request::Collection::MachineLocationHistory
    end

    it 'loads Request::Collection::Assets' do
      assert JD::Request::Collection::Assets
    end

    it 'loads Request::Collection::AssetLocations' do
      assert JD::Request::Collection::AssetLocations
    end

    it 'loads Request::Collection::ContributionProducts' do
      assert JD::Request::Collection::ContributionProducts
    end

    it 'loads Request::Collection::ContributionDefinitions' do
      assert JD::Request::Collection::ContributionDefinitions
    end

    it 'loads Request::Collection::Organizations' do
      assert JD::Request::Collection::Organizations
    end

    it 'loads Request::Collection::Fields' do
      assert JD::Request::Collection::Fields
    end

    it 'loads Request::Collection::Flags' do
      assert JD::Request::Collection::Flags
    end
  end
end
