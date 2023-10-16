defmodule KlaviyoApiClient.Events.EventAttributes do
  use Ecto.Schema

  import Ecto.Changeset, only: [cast: 3]

  alias KlaviyoApiClient.Metrics.Metric
  alias KlaviyoApiClient.Profiles.Profile

  @primary_key false
  @derive Jason.Encoder
  embedded_schema do
    field(:properties, :map, default: %{})
    field(:time, :utc_datetime)
    field(:unique_id, :string)
    field(:value, :decimal)
    embeds_one(:metric, Metric)
    embeds_one(:profile, Profile)
  end

  @spec changeset(MetricAttribute.t(), map) :: Ecto.Changeset.t()
  def changeset(%__MODULE__{} = event_attributes, attrs) when is_map(attrs) do
    event_attributes
    |> cast(attrs, [:properties, :time, :unique_id, :value])
  end
end
