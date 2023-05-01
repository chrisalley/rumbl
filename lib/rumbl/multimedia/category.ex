defmodule Rumbl.Multimedia.Category do
  alias Rumbl.Multimedia.Category
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  @type t :: %__MODULE__{
    id: integer,
    name: String.t,
    inserted_at: String.t,
    updated_at: String.t
  }

  schema "categories" do
    field :name, :string

    timestamps()
  end

  @spec changeset(Category.t, map) :: Ecto.Changeset.t
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end

  @spec alphabetical(Category.t) :: Ecto.Query.t
  def alphabetical(query) do
    from c in query, order_by: c.name
  end
end
