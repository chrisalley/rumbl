defmodule Rumbl.Multimedia.Permalink do
  @behaviour Ecto.Type

  @spec type :: :id
  def type, do: :id

  @spec cast(String.t) :: :error | {:ok, integer}
  def cast(binary) when is_binary(binary) do
    case Integer.parse(binary) do
      {int, _} when int > 0 -> {:ok, int}
      _ -> :error
    end
  end

  @spec cast(integer) :: {:ok, integer}
  def cast(integer) when is_integer(integer) do
    {:ok, integer}
  end

  @spec cast(nil) :: :error
  def cast(_) do
    :error
  end

  @spec dump(integer) :: {:ok, integer}
  def dump(integer) when is_integer(integer) do
    {:ok, integer}
  end

  @spec load(integer) :: {:ok, integer}
  def load(integer) when is_integer(integer) do
    {:ok, integer}
  end
end
