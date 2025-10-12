defmodule KlaviyoApiClient.Profiles.ProfileSubscriptionData do
  use Ecto.Schema

  import Ecto.Changeset, only: [cast: 3, cast_embed: 3]

  @primary_key false
  @derive Jason.Encoder
  embedded_schema do
    embeds_one :marketing, ProfileMarketingSubscriptionData do
      field(:consent, :string)
      field(:consented_at, :utc_datetime)
    end

    embeds_one :transactional, ProfileTransactionalSubscriptionData do
      field(:consent, :string)
      field(:consented_at, :utc_datetime)
    end
  end

  @spec changeset(ProfileSubscriptionData.t(), map) :: Ecto.Changeset.t()
  def changeset(%__MODULE__{} = profile_subscription_data, attrs) when is_map(attrs) do
    profile_subscription_data
    |> cast(attrs, [])
    |> cast_embed(:marketing, with: &marketing_changeset/2)
    |> cast_embed(:transactional, with: &transactional_changeset/2)
  end

  defp marketing_changeset(schema, params) do
    schema
    |> cast(params, [:consent, :consented_at])
  end

  defp transactional_changeset(schema, params) do
    schema
    |> cast(params, [:consent, :consented_at])
  end
end
