defmodule KlaviyoApiClient.Behaviour do
  @moduledoc false

  @callback list_metrics(binary, map) :: {:ok, map()} | {:error, binary | map()}
  @callback list_events(binary, map) :: {:ok, map()} | {:error, binary | map()}
  @callback list_profiles(binary, map) :: {:ok, map()} | {:error, binary | map()}
  @callback create_event(binary, map) :: {:ok, map()} | {:error, map}
end
