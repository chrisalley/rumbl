defmodule Rumbl.Accounts do
  @moduledoc """
  The Accounts context
  """
  import Ecto.Query

  alias Rumbl.Repo
  alias Rumbl.Accounts.User

  @spec get_user(integer) :: User.t
  def get_user(id) do
    Repo.get(User, id)
  end

  @spec get_user!(integer) :: User.t
  def get_user!(id) do
    Repo.get!(User, id)
  end

  @spec get_user_by(username: String.t) :: Ecto.Schema.t | term | nil
  def get_user_by(params) do
    Repo.get_by(User, params)
  end

  @spec list_users :: [Ecto.Schema.t | term]
  def list_users do
    Repo.all(User)
  end

  @spec list_users_with_ids(list[integer]) :: list[User.t]
  def list_users_with_ids(ids) do
    Repo.all(from(u in User, where: u.id in ^ids))
  end

  @spec change_user(User.user) :: Ecto.Changeset.t
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  @spec create_user(map) :: {:ok, Ecto.Schema.t} | {:error, Ecto.Changeset.t}
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @spec change_registration(User.user, map) :: Ecto.Changeset.t
  def change_registration(%User{} = user, params) do
    User.registration_changeset(user, params)
  end

  @spec register_user(map) :: {:ok, Ecto.Schema.t} | {:error, Ecto.Changeset.t}
  def register_user(attrs \\ %{}) do
    %User{}
    |> User.registration_changeset(attrs)
    |> Repo.insert()
  end

  @spec authenticate_by_username_and_pass(String.t, String.t) :: no_return
  def authenticate_by_username_and_pass(username, given_pass) do
    user = get_user_by(username: username)
    cond do
      user && Pbkdf2.verify_pass(given_pass, user.password_hash) -> {:ok, user}
      user -> {:error, :unauthorized}
      true -> Pbkdf2.no_user_verify()
      {:error, :not_found}
    end
  end
end
