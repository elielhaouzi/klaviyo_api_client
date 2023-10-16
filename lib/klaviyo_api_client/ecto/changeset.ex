defmodule KlaviyoApiClient.Extensions.Ecto.Changeset do
  import Ecto.Changeset, only: [cast_embed: 3, get_change: 2, put_change: 3]

  @spec cast_embed_if_loaded(Ecto.Changeset.t(), atom, keyword) :: Ecto.Changeset.t()
  def cast_embed_if_loaded(%Ecto.Changeset{} = changeset, name, opts \\ [])
      when is_atom(name) do
    association = changeset.params |> Map.get(Atom.to_string(name))

    if embed_loaded?(association) do
      changeset |> cast_embed(name, opts)
    else
      changeset
    end
  end

  defp embed_loaded?(%Ecto.Association.NotLoaded{}), do: false
  defp embed_loaded?(_), do: true

  def put_new_change(%Ecto.Changeset{} = changeset, field, value) when is_atom(field) do
    if get_change(changeset, field),
      do: changeset,
      else: changeset |> put_change(field, value)
  end
end
