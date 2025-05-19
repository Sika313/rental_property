defmodule RentalProperty.TIER_UPGRADES do
  @moduledoc """
  The TIER_UPGRADES context.
  """

  import Ecto.Query, warn: false
  alias RentalProperty.Repo

  alias RentalProperty.TIER_UPGRADES.Tier_upgrade

  @doc """
    USER DEFINED FUNCTIONS
  """
  def get_pending_requests do
    query = from t in Tier_upgrade, where: t.status == "pending" 
    Repo.all(query)
  end
  @doc """
  Returns the list of tier_upgrades.

  ## Examples

      iex> list_tier_upgrades()
      [%Tier_upgrade{}, ...]

  """
  def list_tier_upgrades do
    Repo.all(Tier_upgrade)
  end

  @doc """
  Gets a single tier_upgrade.

  Raises `Ecto.NoResultsError` if the Tier upgrade does not exist.

  ## Examples

      iex> get_tier_upgrade!(123)
      %Tier_upgrade{}

      iex> get_tier_upgrade!(456)
      ** (Ecto.NoResultsError)

  """
  def get_tier_upgrade!(id), do: Repo.get!(Tier_upgrade, id)

  @doc """
  Creates a tier_upgrade.

  ## Examples

      iex> create_tier_upgrade(%{field: value})
      {:ok, %Tier_upgrade{}}

      iex> create_tier_upgrade(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_tier_upgrade(attrs \\ %{}) do
    %Tier_upgrade{}
    |> Tier_upgrade.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a tier_upgrade.

  ## Examples

      iex> update_tier_upgrade(tier_upgrade, %{field: new_value})
      {:ok, %Tier_upgrade{}}

      iex> update_tier_upgrade(tier_upgrade, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_tier_upgrade(%Tier_upgrade{} = tier_upgrade, attrs) do
    tier_upgrade
    |> Tier_upgrade.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a tier_upgrade.

  ## Examples

      iex> delete_tier_upgrade(tier_upgrade)
      {:ok, %Tier_upgrade{}}

      iex> delete_tier_upgrade(tier_upgrade)
      {:error, %Ecto.Changeset{}}

  """
  def delete_tier_upgrade(%Tier_upgrade{} = tier_upgrade) do
    Repo.delete(tier_upgrade)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking tier_upgrade changes.

  ## Examples

      iex> change_tier_upgrade(tier_upgrade)
      %Ecto.Changeset{data: %Tier_upgrade{}}

  """
  def change_tier_upgrade(%Tier_upgrade{} = tier_upgrade, attrs \\ %{}) do
    Tier_upgrade.changeset(tier_upgrade, attrs)
  end
end
