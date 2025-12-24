defmodule KlaviyoApiClient.ProfileSubscriptions.ProfileSubscriptionBulkCreateJobProfiles do
  use Ecto.Schema

  import Ecto.Changeset, only: [cast: 3, cast_embed: 3]

  alias KlaviyoApiClient.ProfileSubscriptions.ProfileSubscriptionBulkCreateJobProfile

  @type t :: %__MODULE__{}

  @primary_key false
  @derive Jason.Encoder
  embedded_schema do
    embeds_many(:data, ProfileSubscriptionBulkCreateJobProfile)
  end

  @spec changeset(t, map) :: Ecto.Changeset.t()
  def changeset(%__MODULE__{} = profiles, attrs) when is_map(attrs) do
    profiles
    |> cast(attrs, [])
    |> cast_embed(:data, required: true)
  end
end
