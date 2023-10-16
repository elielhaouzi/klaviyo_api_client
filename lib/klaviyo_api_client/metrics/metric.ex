defmodule KlaviyoApiClient.Metrics.Metric do
  use Ecto.Schema

  import Ecto.Changeset, only: [cast: 3, cast_embed: 3]

  alias KlaviyoApiClient.Metrics.MetricAttributes

  @primary_key false
  @derive Jason.Encoder
  embedded_schema do
    field(:type, :string, default: "metric")
    embeds_one(:attributes, MetricAttributes)
  end

  @spec new!(map) :: Metric.t()
  def new!(fields \\ %{})
  def new!(fields) when is_struct(fields), do: fields |> Map.from_struct() |> new!()

  def new!(fields) when is_map(fields) do
    %__MODULE__{}
    |> changeset(fields)
    |> Ecto.Changeset.apply_action!(:insert)
  end

  @spec changeset(Metric.t(), map) :: Ecto.Changeset.t()
  def changeset(%__MODULE__{} = metric, attrs) when is_map(attrs) do
    metric
    |> cast(attrs, [])
    |> cast_embed(:attributes, required: false)
  end
end
