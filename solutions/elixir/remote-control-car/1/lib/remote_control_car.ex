defmodule RemoteControlCar do
  @enforce_keys [:nickname]
  defstruct [
    :nickname,
    distance_driven_in_meters: 0,
    battery_percentage: 100
  ]

  def new() do
    %RemoteControlCar{
      nickname: "none"
    }
  end

  def new(nickname) do
    %RemoteControlCar{
      nickname: nickname
    }
  end

  def display_distance(%RemoteControlCar{distance_driven_in_meters: distance}) do
    "#{distance} meters"
  end

  def display_battery(%RemoteControlCar{battery_percentage: 0}) do
    "Battery empty"
  end

  def display_battery(%RemoteControlCar{battery_percentage: battery}) do
    "Battery at #{battery}%"
  end

  def drive(%RemoteControlCar{battery_percentage: 0} = remote_car) do
    remote_car
  end

  def drive(
        %RemoteControlCar{
          battery_percentage: battery_percentage,
          distance_driven_in_meters: distance_driven_in_meters
        } = remote_car
      ) do
    %{
      remote_car
      | battery_percentage: battery_percentage - 1,
        distance_driven_in_meters: distance_driven_in_meters + 20
    }
  end
end
