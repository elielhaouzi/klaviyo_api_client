defmodule KlaviyoApiClient.ProfileSubscriptionBulkCreateJobs.ProfileSubscriptionBulkCreateJobAttributes do
  use Ecto.Schema

  import Ecto.Changeset, only: [cast: 3, cast_embed: 2, cast_embed: 3]

  @primary_key false
  @derive Jason.Encoder
  embedded_schema do
    field(:custom_source, :string)
    field(:historical_import, :boolean, default: false)

    embeds_one :profiles, ProfileData do
      embeds_many(:data, Profile)
    end
  end

  @spec changeset(Profile.t(), map) :: Ecto.Changeset.t()
  def changeset(%__MODULE__{} = profile_subscription_bulk_create_job_attributes, attrs)
      when is_map(attrs) do
    profile_subscription_bulk_create_job_attributes
    |> cast(attrs, [:custom_source, :historical_import])
    |> cast_embed(:profiles, with: &profiles_changeset/2)
  end

  defp profiles_changeset(schema, params) do
    schema
    |> cast(params, [])
    |> cast_embed(:data)
  end
end
