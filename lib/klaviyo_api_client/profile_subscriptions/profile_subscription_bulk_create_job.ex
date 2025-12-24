defmodule KlaviyoApiClient.ProfileSubscriptions.ProfileSubscriptionBulkCreateJob do
  use Ecto.Schema

  import Ecto.Changeset, only: [cast: 3, cast_embed: 3]

  alias KlaviyoApiClient.ProfileSubscriptions.ProfileSubscriptionBulkCreateJobAttributes

  @type t :: %__MODULE__{}

  @primary_key false
  @derive Jason.Encoder
  embedded_schema do
    field(:type, :string, default: "profile-subscription-bulk-create-job")
    embeds_one(:attributes, ProfileSubscriptionBulkCreateJobAttributes)
  end

  @spec new!(map) :: t
  def new!(fields \\ %{})
  def new!(fields) when is_struct(fields), do: fields |> Map.from_struct() |> new!()

  def new!(fields) when is_map(fields) do
    %__MODULE__{}
    |> changeset(fields)
    |> Ecto.Changeset.apply_action!(:insert)
  end

  @spec changeset(t, map) :: Ecto.Changeset.t()
  def changeset(%__MODULE__{} = job, attrs) when is_map(attrs) do
    job
    |> cast(attrs, [])
    |> cast_embed(:attributes, required: true)
  end
end
