defmodule KlaviyoApiClient.ProfileSubscriptions.ProfileSubscriptionBulkCreateJobProfileAttributes do
  use Ecto.Schema

  import Ecto.Changeset, only: [cast: 3]

  @type t :: %__MODULE__{}

  @primary_key false
  @derive Jason.Encoder
  embedded_schema do
    field(:email, :string)
    field(:phone_number, :string)
    field(:subscriptions, :map)
  end

  @spec changeset(t, map) :: Ecto.Changeset.t()
  def changeset(%__MODULE__{} = attrs, params) when is_map(params) do
    attrs
    |> cast(params, [:email, :phone_number, :subscriptions])
  end
end
