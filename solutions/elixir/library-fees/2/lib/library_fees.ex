defmodule LibraryFees do
  def datetime_from_string(string) do
    NaiveDateTime.from_iso8601!(string)
  end

  def before_noon?(datetime) do
    datetime.hour < 12
  end

  def return_date(checkout_datetime) when checkout_datetime.hour < 12 do
    checkout_datetime
    |> NaiveDateTime.add(28, :day)
    |> NaiveDateTime.to_date()
  end

  def return_date(checkout_datetime) do
    checkout_datetime
    |> NaiveDateTime.add(29, :day)
    |> NaiveDateTime.to_date()
  end

  def days_late(planned_return_date, actual_return_datetime) do
    Date.diff(actual_return_datetime, planned_return_date)
    |> max(0)
  end

  def monday?(datetime) do
    datetime
    |> NaiveDateTime.to_date()
    |> Date.day_of_week() == 1
  end

  def calculate_late_fee(checkout, return, rate) do
    expected_return_date =
      checkout
      |> datetime_from_string()
      |> return_date()

    return_datetime = datetime_from_string(return)
    days_late = days_late(expected_return_date, return_datetime)
    rate = if monday?(return_datetime), do: rate / 2, else: rate
    Kernel.trunc(days_late * rate)
  end
end
