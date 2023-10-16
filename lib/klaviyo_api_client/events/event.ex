defmodule KlaviyoApiClient.Events.Event do
  use Ecto.Schema

  import Ecto.Changeset, only: [cast: 3, cast_embed: 3]

  alias KlaviyoApiClient.Events.EventAttributes

  @primary_key false
  @derive Jason.Encoder
  embedded_schema do
    field(:type, :string, default: "event")
    embeds_one(:attributes, EventAttributes)
  end

  @spec new!(map) :: Event.t()
  def new!(fields \\ %{})
  def new!(fields) when is_struct(fields), do: fields |> Map.from_struct() |> new!()

  def new!(fields) when is_map(fields) do
    %__MODULE__{}
    |> changeset(fields)
    |> Ecto.Changeset.apply_action!(:insert)
  end

  defp changeset(%__MODULE__{} = event, attrs) when is_map(attrs) do
    event
    |> cast(attrs, [])
    |> cast_embed(:attributes, required: false)
  end
end
