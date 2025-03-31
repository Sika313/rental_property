# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     RentalProperty.Repo.insert!(%RentalProperty.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias RentalProperty.TIERS

data = [ 
  %{type: "client"},
  %{type: "landlord_house"},
  %{type: "landlord_shop"},
  %{type: "seller_house"},
  %{type: "seller_land"},
]

TIERS.create_tier(Enum.at(data, 0))
TIERS.create_tier(Enum.at(data, 1))
TIERS.create_tier(Enum.at(data, 2))
TIERS.create_tier(Enum.at(data, 3))
TIERS.create_tier(Enum.at(data, 4))
