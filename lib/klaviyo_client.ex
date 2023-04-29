defmodule KlaviyoClient do
  @moduledoc """
  Documentation for `KlaviyoClient`.
  """

  alias KlaviyoClient.Links

  @spec list_metrics(binary, map) :: {:ok, map()} | {:error, binary}
  def list_metrics(access_token, %{} = query_params) do
    params = %{
      method: :get,
      resource: "#{base_url()}/metrics" <> "?" <> URI.encode_query(query_params),
      headers: base_headers() |> put_authorization_header(access_token),
      body: %{}
    }

    opts = [obfuscate_keys: ["authorization"]]

    request(params, opts)
    |> handle_response()
  end

  @spec list_events(binary, map) :: {:ok, map()} | {:error, binary}
  def list_events(access_token, %{} = query_params) do
    params = %{
      method: :get,
      resource: "#{base_url()}/events" <> "?" <> URI.encode_query(query_params),
      headers: base_headers() |> put_authorization_header(access_token),
      body: %{}
    }

    opts = [obfuscate_keys: ["authorization"]]

    request(params, opts)
    |> handle_response()
  end

  defp handle_response(response) do
    with {:ok, %{"links" => links, "data" => data}} <- response do
      {:ok, %{"links" => Links.new!(links), "data" => data}}
    end
  end

  defp request(%{method: method, resource: resource, headers: headers, body: body}, opts) do
    AntlHttpClient.request(
      KlaviyoClientFinch,
      "klaviyo",
      %{
        method: method,
        resource: resource,
        headers: %{} = headers,
        body: %{} = body
      },
      Keyword.merge(
        [obfuscate_keys: [], logger: logger(), receive_timeout: receive_timeout()],
        opts
      )
    )
  end

  defp base_headers() do
    %{
      "content-type" => "application/json",
      "user-agent" => "KlaviyoClient/1.0; +(https://github.com/elielhaouzi/klaviyo_client)"
    }
    |> put_revision_header()
  end

  defp put_authorization_header(headers, api_key) when is_binary(api_key) do
    headers |> Map.put("authorization", "Klaviyo-API-Key #{api_key}")
  end

  defp put_revision_header(headers), do: headers |> Map.put("revision", "#{revision()}")
  defp base_url(), do: Application.fetch_env!(:klaviyo_client, :base_url)
  defp logger(), do: Application.get_env(:klaviyo_client, :logger, Logger)
  defp receive_timeout(), do: Application.get_env(:klaviyo_client, :receive_timeout, 50_000)
  defp revision(), do: Application.fetch_env!(:klaviyo_client, :revision)
end
