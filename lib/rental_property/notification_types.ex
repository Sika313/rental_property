defmodule RentalProperty.NOTIFICATION_TYPES do
  @moduledoc """
  The NOTIFICATION_TYPES context.
  """

  import Ecto.Query, warn: false
  alias RentalProperty.Repo

  alias RentalProperty.NOTIFICATION_TYPES.Notification_type

  @doc """
  Returns the list of notification_types.

  ## Examples

      iex> list_notification_types()
      [%Notification_type{}, ...]

  """
  def list_notification_types do
    Repo.all(Notification_type)
  end

  @doc """
  Gets a single notification_type.

  Raises `Ecto.NoResultsError` if the Notification type does not exist.

  ## Examples

      iex> get_notification_type!(123)
      %Notification_type{}

      iex> get_notification_type!(456)
      ** (Ecto.NoResultsError)

  """
  def get_notification_type!(id), do: Repo.get!(Notification_type, id)

  @doc """
  Creates a notification_type.

  ## Examples

      iex> create_notification_type(%{field: value})
      {:ok, %Notification_type{}}

      iex> create_notification_type(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_notification_type(attrs \\ %{}) do
    %Notification_type{}
    |> Notification_type.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a notification_type.

  ## Examples

      iex> update_notification_type(notification_type, %{field: new_value})
      {:ok, %Notification_type{}}

      iex> update_notification_type(notification_type, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_notification_type(%Notification_type{} = notification_type, attrs) do
    notification_type
    |> Notification_type.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a notification_type.

  ## Examples

      iex> delete_notification_type(notification_type)
      {:ok, %Notification_type{}}

      iex> delete_notification_type(notification_type)
      {:error, %Ecto.Changeset{}}

  """
  def delete_notification_type(%Notification_type{} = notification_type) do
    Repo.delete(notification_type)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking notification_type changes.

  ## Examples

      iex> change_notification_type(notification_type)
      %Ecto.Changeset{data: %Notification_type{}}

  """
  def change_notification_type(%Notification_type{} = notification_type, attrs \\ %{}) do
    Notification_type.changeset(notification_type, attrs)
  end
end
