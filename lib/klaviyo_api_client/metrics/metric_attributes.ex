defmodule KlaviyoApiClient.Metrics.MetricAttributes do
  use Ecto.Schema

  import Ecto.Changeset, only: [cast: 3, validate_required: 2]

  @primary_key false
  @derive Jason.Encoder
  embedded_schema do
    field(:name, :string)
    field(:service, :string)
  end

  @spec changeset(MetricAttribute.t(), map) :: Ecto.Changeset.t()
  def changeset(%__MODULE__{} = metric_attribute, attrs) when is_map(attrs) do
    metric_attribute
    |> cast(attrs, [:name, :service])
    |> validate_required([:name])
  end
end
