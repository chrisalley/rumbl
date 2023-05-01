defmodule RumblWeb.PageController do
  use RumblWeb, :controller

  @spec index(Plug.Conn.t, nil) :: Plug.Conn.t
  def index(conn, _params) do
    render(conn, "index.html")
  end
end
