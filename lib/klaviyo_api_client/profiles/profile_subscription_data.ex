defmodule KlaviyoApiClient.Profiles.ProfileSubscriptionData do
  use Ecto.Schema

  import Ecto.Changeset, only: [cast: 3, cast_embed: 2]

  alias KlaviyoApiClient.Profiles.SubscriptionData

  @primary_key false
  @derive Jason.Encoder
  embedded_schema do
    embeds_one(:marketing, SubscriptionData)
    embeds_one(:transactional, SubscriptionData)
  end

  @spec changeset(ProfileSubscriptionData.t(), map) :: Ecto.Changeset.t()
  def changeset(%__MODULE__{} = profile_subscription_data, attrs) when is_map(attrs) do
    profile_subscription_data
    |> cast(attrs, [])
    |> cast_embed(:marketing)
    |> cast_embed(:transactional)
  end
end
