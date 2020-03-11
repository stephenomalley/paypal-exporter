import Config

config :paypal_exporter, PaypalExporter.Scheduler,
  jobs: [
    # Every minute
    #{"10 18 * * *",   fn -> PaypalExporter.Server.retrive_daily_transactions()  end},
  ]
config :goth, json: {:system, "GCP_CREDENTIALS"}, disabled: System.get_env("GCP_DISABLED") == "true"
