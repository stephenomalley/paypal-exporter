defmodule PaypalExporter.Paypal do
@moduledoc """



"""

  @accept_header ["Accept": "application/json"]
  @content_type_header ["Content-Type": "application/x-www-form-urlencoded"]

  def get_oauth_token do
    settings = %PaypalExporter.Settings{}
    url = settings.url
    body = {:form, [grant_type: "client_credentials"]}
    options = [hackney: [basic_auth: {settings.client_id, settings.secret_id}]]

    response = HTTPoison.post!("#{url}/v1/oauth2/token", body, @content_type_header, options)
    %{"access_token" => access_token} = Poison.decode!(response.body)
    access_token
  end

  def get_transactions do
    date_string = Date.utc_today() |> Date.add(-1) |> Date.to_iso8601
    headers = get_oauth_token() |> auth_headers
    url = %PaypalExporter.Settings{}.url
    get_transactions("#{url}/v1/reporting/transactions?start_date=#{date_string}T00:00:00-0700&end_date=#{date_string}T23:59:59-0700&fields=payer_info&page_size=100", headers)
  end

  def get_transactions(url, _) when url == nil do "" end

  def get_transactions(url, headers) do
    response = HTTPoison.get!(url, headers)
    response_data = Poison.decode!(response.body)
    transaction_data = response_data["transaction_details"] |> Enum.filter(&PaypalExporter.Utils.filter_paypal_response/1) |> Enum.map(&PaypalExporter.Utils.parse_paypal_response/1) |> Enum.join("\n")

    transaction_data <> get_transactions(response_data |> find_next_link |> get_next_url, headers)

  end

  def auth_headers(token) do
    ["Authorization": "Bearer #{token}"] ++ @accept_header
  end

  def find_next_link(response) do
    Enum.find(response["links"], fn link -> link["rel"] == "next" end)
  end

  def get_next_url(next_link)  when next_link == nil do end
  def get_next_url(next_link) do next_link["href"] end



end
