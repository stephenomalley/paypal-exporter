defmodule PaypalExporter.Utils do

  def parse_paypal_response(response) do
    transaction_info = response["transaction_info"]
    payer_info = response["payer_info"]
    [
      transaction_info["transaction_id"],
      transaction_info["transaction_event_code"],
      payer_info["address_status"] |> parse_paypal_status,
      payer_info["country_code"],
      payer_info["payer_status"] |> parse_paypal_status,
      payer_info["payer_name"] |> name
    ] |> Enum.join(",")

  end

  def filter_paypal_response(response) do
    String.starts_with?(response["transaction_info"]["transaction_event_code"], "T00")
  end

  def parse_paypal_status(status) do %{"Y" => "Verified", "N" => "Unverified", nil => "Unknown"}[status] end
  def name(%{"alterative_full_name" => value}) do value end
  def name(%{"given_name" => firstname, "surname" => surname}) do "#{firstname} #{surname}" end
  def name(_) do "N/A" end


end
