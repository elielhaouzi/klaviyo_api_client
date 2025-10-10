defmodule KlaviyoApiClient do
  @moduledoc """
  Documentation for `KlaviyoApiClient`.
  """
  @behaviour KlaviyoApiClient.Behaviour

  require Logger

  alias KlaviyoApiClient.Events.Event
  alias KlaviyoApiClient.Metrics.Metric
  alias KlaviyoApiClient.Profiles.Profile
  alias KlaviyoApiClient.Links

  @spec list_metrics(binary, map) :: {:ok, map()} | {:error, binary | map()}
  def list_metrics(api_key, %{} = query_params) do
    new_req(base_url: api_base_url())
    |> Req.request(
      method: :get,
      url: "/metrics",
      params: query_params,
      auth: api_key_header_value(api_key)
    )
    |> handle_response()
    |> handle_list_response(&Metric.new!/1)
  end

  @spec list_events(binary, map) :: {:ok, map()} | {:error, binary | map()}
  def list_events(api_key, %{} = query_params) do
    new_req(base_url: api_base_url())
    |> Req.request(
      method: :get,
      url: "/events",
      params: query_params,
      auth: api_key_header_value(api_key)
    )
    |> handle_response()
    |> handle_list_response(&Event.new!/1)
  end

  @spec list_profiles(binary, map) :: {:ok, map()} | {:error, binary | map()}
  def list_profiles(api_key, %{} = query_params) do
    new_req(base_url: api_base_url())
    |> Req.request(
      method: :get,
      url: "/profiles",
      params: query_params,
      auth: api_key_header_value(api_key)
    )
    |> handle_response()
    |> handle_list_response(&Profile.new!/1)
  end

  @spec create_event(binary, map) :: {:ok, nil} | {:error, tuple}
  def create_event(api_key, %{} = body) do
    new_req(base_url: api_base_url())
    |> Req.request(
      method: :post,
      url: "/events",
      json: body,
      auth: {:string, api_key}
    )
    |> handle_response()
    |> case do
      {:ok, ""} -> {:ok, nil}
      error -> error
    end
  end

  @spec create_profile(binary, map) :: {:ok, map()} | {:error, tuple}
  def create_profile(api_key, %{} = body) do
    new_req(base_url: api_base_url())
    |> Req.request(
      method: :post,
      url: "/profiles",
      json: body,
      auth: api_key_header_value(api_key)
    )
    |> handle_response()
    |> case do
      {:ok, ""} -> {:ok, nil}
      error -> error
    end
  end

  @spec update_profile(binary, binary, map) :: {:ok, map()} | {:error, tuple}
  def update_profile(api_key, profile_id, %{} = body) when is_binary(profile_id) do
    new_req(base_url: api_base_url())
    |> Req.request(
      method: :patch,
      url: "/profiles/#{profile_id}",
      json: body,
      auth: api_key_header_value(api_key)
    )
    |> handle_response()
    |> case do
      {:ok, ""} -> {:ok, nil}
      error -> error
    end
  end

  @spec bulk_subscribe_profiles(binary, map) :: {:ok, map()} | {:error, tuple}
  def bulk_subscribe_profiles(api_key, %{} = body) do
    new_req(base_url: api_base_url())
    |> Req.request(
      method: :post,
      url: "/profile-subscription-bulk-create-jobs/",
      json: body,
      auth: api_key_header_value(api_key)
    )
    |> handle_response()
  end

  defp handle_list_response(response, fun) do
    with {:ok, %{"links" => links, "data" => data}} <- response do
      {:ok, %{"links" => Links.new!(links), "data" => Enum.map(data, fun)}}
    end
  end

  defp new_req(opts) do
    log_request = fn %Req.Request{} = request ->
      focused_request = %Req.Request{
        method: request.method,
        url: request.url,
        headers: request.headers,
        body: request.body
      }

      Logger.debug("KlaviyoApiClient request: #{inspect(focused_request, pretty: true)}")

      request
    end

    log_response = fn {%Req.Request{} = request, %Req.Response{} = response} ->
      Logger.debug("KlaviyoApiClient response: #{inspect(response, pretty: true)}")

      {request, response}
    end

    [
      user_agent: user_agent(),
      receive_timeout: receive_timeout()
    ]
    |> Keyword.merge(opts)
    |> Keyword.merge(Application.get_env(:klaviyo_api_client, :req_options, []))
    |> Req.new()
    |> Req.Request.put_header("revision", revision())
    |> Req.Request.append_request_steps(log_request: log_request)
    |> Req.Request.append_response_steps(log_response: log_response)
  end

  defp handle_response({:ok, %Req.Response{} = response}) do
    case response do
      %{status: status, body: body} when status in 200..299 ->
        {:ok, body}

      %{status: status, headers: headers} when status in [301, 302, 303, 307, 308] ->
        {:ok, headers}

      %{status: status, body: body} when status in 400..499 ->
        {:error, {status, body}}

      %{status: status, body: body} when status >= 500 ->
        {:error, {status, body}}
    end
  end

  defp handle_response({:error, error}) do
    {:error, {inspect(error.__struct__), Exception.message(error)}}
  end

  defp user_agent() do
    Application.get_env(
      :klaviyo_api_client,
      :user_agent,
      "KlaviyoApiClient/1.0; +(https://github.com/elielhaouzi/klaviyo_api_client)"
    )
  end

  defp receive_timeout(), do: Application.get_env(:klaviyo_api_client, :receive_timeout, 50_000)
  defp revision(), do: Application.get_env(:klaviyo_api_client, :revision, "2025-07-15")

  defp api_key_header_value(api_key) when is_binary(api_key), do: "Klaviyo-API-Key #{api_key}"

  defp api_base_url(),
    do: Application.get_env(:klaviyo_api_client, :base_url, "https://a.klaviyo.com/api")
end
