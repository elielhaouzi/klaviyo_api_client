defmodule KlaviyoApiClient do
  @moduledoc """
  Documentation for `KlaviyoApiClient`.
  """

  alias KlaviyoApiClient.Events.Event
  alias KlaviyoApiClient.Metrics.Metric
  alias KlaviyoApiClient.Profiles.Profile
  alias KlaviyoApiClient.Links

  @spec list_metrics(binary, map) :: {:ok, map()} | {:error, binary | map()}
  def list_metrics(access_token, %{} = query_params) do
    params = %{
      method: :get,
      resource: "#{base_url()}/metrics" <> "?" <> URI.encode_query(query_params),
      headers: base_headers() |> put_authorization_header(access_token),
      body: %{}
    }

    opts = [obfuscate_keys: ["authorization"]]

    request(params, opts)
    |> handle_list_response(&Metric.new!/1)
  end

  @spec list_events(binary, map) :: {:ok, map()} | {:error, binary | map()}
  def list_events(access_token, %{} = query_params) do
    params = %{
      method: :get,
      resource: "#{base_url()}/events" <> "?" <> URI.encode_query(query_params),
      headers: base_headers() |> put_authorization_header(access_token),
      body: %{}
    }

    opts = [obfuscate_keys: ["authorization"]]

    request(params, opts)
    |> handle_list_response(&Event.new!/1)
  end

  @spec list_profiles(binary, map) :: {:ok, map()} | {:error, binary | map()}
  def list_profiles(access_token, %{} = query_params) do
    params = %{
      method: :get,
      resource: "#{base_url()}/profiles" <> "?" <> URI.encode_query(query_params),
      headers: base_headers() |> put_authorization_header(access_token),
      body: %{}
    }

    opts = [obfuscate_keys: ["authorization"]]

    request(params, opts)
    |> handle_list_response(&Profile.new!/1)
  end

  @spec create_event(binary, map) :: {:ok, nil} | {:error, map}
  def create_event(access_token, %{} = body) do
    params = %{
      method: :post,
      resource: "#{base_url()}/events",
      headers: base_headers() |> put_authorization_header(access_token),
      body: body
    }

    opts = [obfuscate_keys: ["authorization"]]

    request(params, opts)
    |> case do
      {:ok, ""} -> {:ok, nil}
      error -> error
    end
  end

  defp handle_list_response(response, fun) do
    with {:ok, %{"links" => links, "data" => data}} <- response do
      {:ok, %{"links" => Links.new!(links), "data" => Enum.map(data, fun)}}
    end
  end

  defp request(%{method: method, resource: resource, headers: headers, body: body}, opts) do
    AntlHttpClient.request(
      finch_instance(),
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
      "user-agent" => "KlaviyoApiClient/1.0; +(https://github.com/elielhaouzi/klaviyo_api_client)"
    }
    |> put_revision_header()
  end

  defp put_authorization_header(headers, api_key) when is_binary(api_key) do
    headers |> Map.put("authorization", "Klaviyo-API-Key #{api_key}")
  end

  defp put_revision_header(headers), do: headers |> Map.put("revision", "#{revision()}")

  defp finch_instance(),
    do: Application.get_env(:klaviyo_api_client, :finch_instance, KlaviyoApiClientFinch)

  defp base_url(), do: Application.fetch_env!(:klaviyo_api_client, :base_url)
  defp logger(), do: Application.get_env(:klaviyo_api_client, :logger, Logger)
  defp receive_timeout(), do: Application.get_env(:klaviyo_api_client, :receive_timeout, 50_000)
  defp revision(), do: Application.fetch_env!(:klaviyo_api_client, :revision)
end
