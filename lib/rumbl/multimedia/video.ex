defmodule Rumbl.Multimedia.Video do
  use Ecto.Schema
  import Ecto.Changeset

   @type t :: %__MODULE__{
    id: integer,
    description: String.t,
    title: String.t,
    url: String.t,
    slug: String.t,
    inserted_at: String.t,
    updated_at: String.t
  }

  @primary_key {:id, Rumbl.Multimedia.Permalink, autogenerate: true}
  schema "videos" do
    field :description, :string
    field :title, :string
    field :url, :string
    field :slug, :string

    belongs_to :user, Rumbl.Accounts.User
    belongs_to :category, Rumbl.Multimedia.Category
    has_many :annotations, Rumbl.Multimedia.Annotation

    timestamps()
  end

  @spec changeset(Video.t, map) :: Changeset.t
  def changeset(video, attrs) do
    video
    |> cast(attrs, [:url, :title, :description, :category_id])
    |> validate_required([:url, :title, :description])
    |> assoc_constraint(:category)
    |> slugify_title()
  end

  @spec slugify_title(map) :: Video.t | :error
  defp slugify_title(changeset) do
    case fetch_change(changeset, :title) do
      {:ok, new_title} -> put_change(changeset, :slug, slugify(new_title))
      :error -> changeset
    end
  end

  @spec slugify(String.t) :: String.t
  defp slugify(str) do
    str
    |> String.downcase()
    |> String.replace(~r/[^\w-]+/u, "-")
  end
end
