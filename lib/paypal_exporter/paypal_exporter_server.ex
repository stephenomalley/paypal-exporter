defmodule PaypalExporter.Server do

    use GenServer

    def start_link do
      GenServer.start_link(__MODULE__, :ok, name: :paypal_server)
    end

    def retrive_daily_transactions do
      GenServer.cast(:paypal_server, {})
    end

    @impl true
    def init(:ok) do
      {:ok, %{}}
    end

    @impl true
    def handle_cast(_, _) do
      PaypalExporter.Paypal.get_transactions() |> PaypalExporter.GCPUpload.upload
      {:noreply, %{}}
    end

end
