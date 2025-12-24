defmodule KlaviyoApiClient.ProfileSubscriptions.ProfileSubscriptionBulkCreateJobAttributes do
  use Ecto.Schema

  import Ecto.Changeset, only: [cast: 3, cast_embed: 3]

  alias KlaviyoApiClient.ProfileSubscriptions.ProfileSubscriptionBulkCreateJobProfiles

  @type t :: %__MODULE__{}

  @primary_key false
  @derive Jason.Encoder
  embedded_schema do
    field(:custom_source, :string)
    field(:historical_import, :boolean)
    embeds_one(:profiles, ProfileSubscriptionBulkCreateJobProfiles)
  end

  @spec changeset(t, map) :: Ecto.Changeset.t()
  def changeset(%__MODULE__{} = attrs, params) when is_map(params) do
    attrs
    |> cast(params, [:custom_source, :historical_import])
    |> cast_embed(:profiles, required: true)
  end
end
