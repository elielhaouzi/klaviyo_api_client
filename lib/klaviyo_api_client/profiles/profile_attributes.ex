defmodule KlaviyoApiClient.Profiles.ProfileAttributes do
  use Ecto.Schema

  import Ecto.Changeset, only: [cast: 3, cast_embed: 2]

  alias KlaviyoApiClient.Profiles.ProfileLocation
  alias KlaviyoApiClient.Profiles.ProfileSubscriptions

  @primary_key false
  @derive Jason.Encoder
  embedded_schema do
    field(:email, :string)
    field(:external_id, :string)
    field(:first_name, :string)
    field(:image, :string)
    field(:last_name, :string)
    field(:organization, :string)
    field(:phone_number, :string)
    field(:properties, :map)
    field(:title, :string)
    embeds_one(:location, ProfileLocation)
    embeds_one(:subscriptions, ProfileSubscriptions)
  end

  @spec changeset(ProfileAttributes.t(), map) :: Ecto.Changeset.t()
  def changeset(%__MODULE__{} = profile_attributes, attrs) when is_map(attrs) do
    profile_attributes
    |> cast(attrs, [
      :email,
      :external_id,
      :first_name,
      :image,
      :last_name,
      :organization,
      :phone_number,
      :properties,
      :title
    ])
    |> cast_embed(:location)
    |> cast_embed(:subscriptions)
  end
end
