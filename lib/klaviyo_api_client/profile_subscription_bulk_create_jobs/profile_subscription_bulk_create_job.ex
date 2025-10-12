defmodule KlaviyoApiClient.ProfileSubscriptionBulkCreateJobs.ProfileSubscriptionBulkCreateJob do
  use Ecto.Schema

  import Ecto.Changeset, only: [cast: 3, cast_embed: 3]

  alias KlaviyoApiClient.ProfileSubscriptionBulkCreateJobs.ProfileSubscriptionBulkCreateJobAttributes

  @primary_key false
  @derive Jason.Encoder
  embedded_schema do
    field(:id, :string)
    embeds_one(:attributes, ProfileSubscriptionBulkCreateJobAttributes)
    field(:type, :string, default: "profile-subscription-bulk-create-job")
  end

  @spec new!(map) :: ProfileSubscriptionBulkCreateJob.t()
  def new!(fields \\ %{})
  def new!(fields) when is_struct(fields), do: fields |> Map.from_struct() |> new!()

  def new!(fields) when is_map(fields) do
    %__MODULE__{}
    |> changeset(fields)
    |> Ecto.Changeset.apply_action!(:insert)
  end

  @spec changeset(ProfileSubscriptionBulkCreateJob.t(), map) :: Ecto.Changeset.t()
  def changeset(%__MODULE__{} = profile_subscription_bulk_create_job, attrs) when is_map(attrs) do
    profile_subscription_bulk_create_job
    |> cast(attrs, [:id])
    |> cast_embed(:attributes, required: false)
  end
end
