defmodule KlaviyoApiClient.Profiles.Profile do
  use Ecto.Schema

  import Ecto.Changeset, only: [cast: 3, cast_embed: 3]

  alias KlaviyoApiClient.Profiles.ProfileAttributes

  @primary_key false
  @derive Jason.Encoder
  embedded_schema do
    field(:id, :string)
    field(:type, :string, default: "profile")
    embeds_one(:attributes, ProfileAttributes)
  end

  @spec new!(map) :: Profile.t()
  def new!(fields \\ %{})
  def new!(fields) when is_struct(fields), do: fields |> Map.from_struct() |> new!()

  def new!(fields) when is_map(fields) do
    %__MODULE__{}
    |> changeset(fields)
    |> Ecto.Changeset.apply_action!(:insert)
  end

  @spec changeset(Profile.t(), map) :: Ecto.Changeset.t()
  def changeset(%__MODULE__{} = profile, attrs) when is_map(attrs) do
    profile
    |> cast(attrs, [:id])
    |> cast_embed(:attributes, required: false)
  end
end
