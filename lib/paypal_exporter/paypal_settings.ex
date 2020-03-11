defmodule PaypalExporter.Settings do

  defstruct client_id: System.get_env("PAYPAL_CLIENT_ID"), url: System.get_env("PAYPAL_URL"), secret_id: System.get_env("PAYPAL_SECRET_ID")

end
