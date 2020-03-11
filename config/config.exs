import Config

config :paypal_exporter, PaypalExporter.Scheduler,
  jobs: [
    # Every minute
    #{"10 18 * * *",   fn -> PaypalExporter.Server.retrive_daily_transactions()  end},
  ]
config :goth,
json: "/home/stephen/playgrounds/elixir/paypal_exporter/priv/gcp.json" |> File.read!



