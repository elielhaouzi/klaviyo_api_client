defmodule KlaviyoApiClient.Profiles.ProfileLocation do
  use Ecto.Schema

  import Ecto.Changeset, only: [cast: 3]

  @primary_key false
  @derive Jason.Encoder
  embedded_schema do
    field(:address1, :string)
    field(:address2, :string)
    field(:city, :string)
    field(:country, :string)
    field(:ip, :string)
    field(:region, :string)
    field(:timezone, :string)
    field(:zip, :string)
  end

  @spec changeset(ProfileLocation.t(), map) :: Ecto.Changeset.t()
  def changeset(%__MODULE__{} = profile_location, attrs) when is_map(attrs) do
    profile_location
    |> cast(attrs, [:address1, :address2, :city, :country, :ip, :region, :timezone, :zip])
  end
end
