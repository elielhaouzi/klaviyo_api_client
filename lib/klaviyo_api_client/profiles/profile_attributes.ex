defmodule KlaviyoApiClient.Profiles.ProfileAttributes do
  use Ecto.Schema

  import Ecto.Changeset, only: [cast: 3]

  alias KlaviyoApiClient.Profiles.ProfileLocation

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
  end

  @spec changeset(Profile.t(), map) :: Ecto.Changeset.t()
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
  end
end
