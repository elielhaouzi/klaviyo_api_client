defmodule KlaviyoApiClient.Profiles.ProfileSubscriptions do
  use Ecto.Schema

  import Ecto.Changeset, only: [cast: 3, cast_embed: 2]

  alias KlaviyoApiClient.Profiles.ProfileSubscriptionData

  @primary_key false
  @derive Jason.Encoder
  embedded_schema do
    embeds_one(:email, ProfileSubscriptionData)
    embeds_one(:sms, ProfileSubscriptionData)
    embeds_one(:whatsapp, ProfileSubscriptionData)
  end

  @spec changeset(ProfileSubscriptions.t(), map) :: Ecto.Changeset.t()
  def changeset(%__MODULE__{} = profile_subscription, attrs) when is_map(attrs) do
    profile_subscription
    |> cast(attrs, [])
    |> cast_embed(:email)
    |> cast_embed(:sms)
    |> cast_embed(:whatsapp)
  end
end
