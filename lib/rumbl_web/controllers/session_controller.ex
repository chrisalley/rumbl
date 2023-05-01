defmodule RumblWeb.SessionController do
  use RumblWeb, :controller

  @spec new(Plug.Conn.t, nil) :: Plug.Conn.t
  def new(conn, _) do
    render(conn, "new.html")
  end

  @spec create(Plug.Conn, map) :: no_return
  def create(conn, %{"session" => %{"username" => username, "password" => pass}}) do
    case Rumbl.Accounts.authenticate_by_username_and_pass(username, pass) do
      {:ok, user} ->
        conn
        |> RumblWeb.Auth.login(user)
        |> put_flash(:info, "Welcome back!")
        |> redirect(to: Routes.page_path(conn, :index))
      {:error, _reason} ->
        conn
        |> put_flash(:error, "Invalid username/password combination.")
        |> render("new.html")
    end
  end

  @spec delete(Plug.Conn.t, nil) :: Plug.Conn.t
  def delete(conn, _) do
    conn
    |> RumblWeb.Auth.logout()
    |> redirect(to: Routes.page_path(conn, :index))
  end
end
