import Config
config :paypal_server, :secret_id, System.fetch_env!("PAYPAL_SECRET_ID"), :client_id, System.fetch_env!("PAYPAL_CLIENT_ID"), url, System.fetch_env!("PAYPAL_URL")
