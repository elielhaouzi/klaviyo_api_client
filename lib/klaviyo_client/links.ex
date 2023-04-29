defmodule KlaviyoClient.Links do
  use Ecto.Schema

  import Ecto.Changeset, only: [cast: 3]

  alias KlaviyoClient.Ecto.Types.URI

  @primary_key false
  embedded_schema do
    field(:next, URI)
    field(:prev, URI)
    field(:self, URI)
  end

  @spec new!(map) :: Links.t()
  def new!(fields \\ %{})
  def new!(fields) when is_struct(fields), do: fields |> Map.from_struct() |> new!()

  def new!(fields) when is_map(fields) do
    %__MODULE__{}
    |> changeset(fields)
    |> Ecto.Changeset.apply_action!(:insert)
  end

  defp changeset(%__MODULE__{} = links, attrs) when is_map(attrs) do
    links
    |> cast(attrs, [:next, :prev, :self])
  end
end
