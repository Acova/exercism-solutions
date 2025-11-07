# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start(opts \\ []) do
    Agent.start(fn -> %{plots: [], total: 0} end, opts)
  end

  def list_registrations(pid) do
    Agent.get(pid, fn state -> state.plots end)
  end

  def register(pid, register_to) do
    Agent.get_and_update(pid, fn state ->
      new_plot_id = state.total + 1
      plot = %Plot{plot_id: new_plot_id, registered_to: register_to}
      new_state = %{state | plots: [plot | state.plots], total: new_plot_id}
      {plot, new_state}
    end)
  end

  def release(pid, plot_id) do
    Agent.update(pid, fn state ->
      updated_plots = Enum.reject(state.plots, fn plot -> plot.plot_id == plot_id end)
      %{state | plots: updated_plots}
    end)
  end

  def get_registration(pid, plot_id) do
    Agent.get(pid, fn state ->
      case Enum.find(state.plots, fn plot -> plot.plot_id == plot_id end) do
        nil -> {:not_found, "plot is unregistered"}
        plot -> plot
      end
    end)
  end
end
