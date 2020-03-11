defmodule PaypalExporter.GCPUpload do

  def upload(data) do
    {:ok, token} = Goth.Token.for_scope("https://www.googleapis.com/auth/cloud-platform")
    conn = GoogleApi.Storage.V1.Connection.new(token.token)
    transaction_date = Date.utc_today() |> Date.add(-1) |> Date.to_iso8601
    GoogleApi.Storage.V1.Api.Objects.storage_objects_insert_iodata(
        conn,
        "stephen-gcp-paypal",
        "multipart",
        %GoogleApi.Storage.V1.Model.Object{name: "paypal-#{transaction_date}.csv"},
        data
      )
  end

end
