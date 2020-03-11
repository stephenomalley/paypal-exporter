defmodule PaypalExporter.Scheduler do
  use Quantum.Scheduler,
    otp_app: :paypal_exporter
end
