defmodule TakeANumber do
  def start() do
    spawn(fn -> report_state(0) end)
  end

  def report_state(state) do
    receive do
      {:report_state, sender_pid} ->
        send(sender_pid, state)
        report_state(state)

      {:take_a_number, sender_pid} ->
        new_state = state + 1
        send(sender_pid, new_state)
        report_state(new_state)

      :stop ->
        nil

      _other ->
        report_state(state)
    end
  end
end
