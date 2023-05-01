defmodule Rumbl.Multimedia.Annotation do
  alias Rumbl.Multimedia.Annotation
  use Ecto.Schema
  import Ecto.Changeset

   @type t :: %__MODULE__{
    id: integer,
    at: integer,
    body: String.t,
    inserted_at: String.t,
    updated_at: String.t
  }

  schema "annotations" do
    field :at, :integer
    field :body, :string

    belongs_to :user, Rumbl.Accounts.User
    belongs_to :video, Rumbl.Multimedia.Video

    timestamps()
  end

  @spec changeset(Annotation.t, map) :: Changeset.t
  def changeset(annotation, attrs) do
    annotation
    |> cast(attrs, [:body, :at])
    |> validate_required([:body, :at])
  end
end
