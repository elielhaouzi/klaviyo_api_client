defmodule KlaviyoApiClient.Profiles.SubscriptionData do
  use Ecto.Schema

  import Ecto.Changeset, only: [cast: 3]

  @primary_key false
  @derive Jason.Encoder
  embedded_schema do
    field(:consent, :string)
    field(:consented_at, :utc_datetime)
  end

  @spec changeset(SubscriptionData.t(), map) :: Ecto.Changeset.t()
  def changeset(%__MODULE__{} = subscription_data, attrs) when is_map(attrs) do
    subscription_data
    |> cast(attrs, [:consent, :consented_at])
  end
end
