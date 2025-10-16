defmodule KlaviyoApiClient.Lists.List do
  use Ecto.Schema

  import Ecto.Changeset, only: [cast: 3]

  @primary_key false
  @derive Jason.Encoder
  embedded_schema do
    field(:id, :string)
    field(:type, :string, default: "list")
  end

  @spec new!(map) :: List.t()
  def new!(fields \\ %{})
  def new!(fields) when is_struct(fields), do: fields |> Map.from_struct() |> new!()

  def new!(fields) when is_map(fields) do
    %__MODULE__{}
    |> changeset(fields)
    |> Ecto.Changeset.apply_action!(:insert)
  end

  @spec changeset(List.t(), map) :: Ecto.Changeset.t()
  def changeset(%__MODULE__{} = list, attrs) when is_map(attrs) do
    list
    |> cast(attrs, [:id])
  end
end
