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
alias RentalProperty.TYPES
alias RentalProperty.DISTRICT
alias RentalProperty.PROVINCES
alias RentalProperty.ROLES
alias RentalProperty.USERS

roles = [
  %{name: "ADMIN", description: "Super User", permissions: ["ALL"]},
  %{name: "ACCOUNTANT", description: "Collect payments and ensure they are valid", permissions: ["receive_payment", "request_tier_upgrade"]}
]
for role <- roles do
  ROLES.create_role(role)
end
admin = %{
 fname: "Mashekwa",
 lname: "Sikatema",
 gender: "m",
 phone: "0779567086",
 password: "12345",
 role_id: 1,
 token: UUID.uuid4()
}
USERS.create_user(admin)
client_types = [ 
  %{type: "client"},
  %{type: "landlord_house"},
  %{type: "landlord_shop"},
  %{type: "landlord_bh"},
  %{type: "seller_house"},
  %{type: "seller_land"}
]

property_types = [
  %{property_type: "House"},
  %{property_type: "shop"},
  %{property_type: "Boarding house"},
  %{property_type: "House for sell"},
  %{property_type: "Land for sell"}
]

provinces = [
  %{name: "Central"},
  %{name: "Copperbelt"},
  %{name: "Eastern"},
  %{name: "Luapula"},
  %{name: "Lusaka"},
  %{name: "Muchinga"},
  %{name: "Northern"},
  %{name: "North-Western"},
  %{name: "Southern"},
  %{name: "Western"},
]

districts = [
  %{name: "Chibombo", province_id: 1},
  %{name: "Chisamba", province_id: 1},
  %{name: "Chitambo", province_id: 1},
  %{name: "Kabwe", province_id: 1},
  %{name: "Kapiri Mphoshi", province_id: 1},
  %{name: "Luano", province_id: 1},
  %{name: "Mkushi", province_id: 1},
  %{name: "Mumbwa", province_id: 1},
  %{name: "Ngabwe", province_id: 1},
  %{name: "Serenje", province_id: 1},
  %{name: "Shibuyunji", province_id: 1},
  %{name: "Chililabombwe", province_id: 2},
  %{name: "Chingola", province_id: 2},
  %{name: "Kalulushi", province_id: 2},
  %{name: "Kitwe", province_id: 2},
  %{name: "Luanshya", province_id: 2},
  %{name: "Lufwanyama", province_id: 2},
  %{name: "Masaiti", province_id: 2},
  %{name: "Mpongwe", province_id: 2},
  %{name: "Mufulira", province_id: 2},
  %{name: "Ndola", province_id: 2},
  %{name: "Chadiza", province_id: 3},
  %{name: "Chama", province_id: 3},
  %{name: "Chasefu", province_id: 3},
  %{name: "Chipangali", province_id: 3},
  %{name: "Chipata", province_id: 3},
  %{name: "Kasenengwa", province_id: 3},
  %{name: "Katete", province_id: 3},
  %{name: "Lumezi", province_id: 3},
  %{name: "Lundazi", province_id: 3},
  %{name: "Lusangazi", province_id: 3},
  %{name: "Mambwe", province_id: 3},
  %{name: "Nyimba", province_id: 3},
  %{name: "Petauke", province_id: 3},
  %{name: "Sinda", province_id: 3},
  %{name: "Vubwi", province_id: 3},
  %{name: "Chembe", province_id: 4},
  %{name: "Chilengi", province_id: 4},
  %{name: "Chibunabuli", province_id: 4},
  %{name: "Chipili", province_id: 4},
  %{name: "Kawambwa", province_id: 4},
  %{name: "Lunga", province_id: 4},
  %{name: "Mansa", province_id: 4},
  %{name: "Milenge", province_id: 4},
  %{name: "Mwansabombwe", province_id: 4},
  %{name: "Mwense", province_id: 4},
  %{name: "Nchelenge", province_id: 4},
  %{name: "Samfya", province_id: 4},
  %{name: "Chilanga", province_id: 5},
  %{name: "Chongwe", province_id: 5},
  %{name: "Kafue", province_id: 5},
  %{name: "Luangwa", province_id: 5},
  %{name: "Lusaka", province_id: 5},
  %{name: "Rufunsa", province_id: 5},
  %{name: "Chinsali", province_id: 6},
  %{name: "Isoka", province_id: 6},
  %{name: "Mafinga", province_id: 6},
  %{name: "Mpika", province_id: 6},
  %{name: "Nakonde", province_id: 6},
  %{name: "Shiwangandu", province_id: 6},
  %{name: "Kanchibiya", province_id: 6},
  %{name: "Lavushimanda", province_id: 6},
  %{name: "Chilubi", province_id: 7},
  %{name: "Kaputa", province_id: 7},
  %{name: "Kasama", province_id: 7},
  %{name: "Luwingu", province_id: 7},
  %{name: "Mbala", province_id: 7},
  %{name: "Mporokoso", province_id: 7},
  %{name: "Mpulungu", province_id: 7},
  %{name: "Mungwi", province_id: 7},
  %{name: "Lupososhi", province_id: 7},
  %{name: "Senga Hill", province_id: 7},
  %{name: "Lunte", province_id: 7},
  %{name: "Nsama", province_id: 7},
  %{name: "Chavuma", province_id: 8},
  %{name: "Ikelenge", province_id: 8},
  %{name: "Kabompo", province_id: 8},
  %{name: "Kalumbila", province_id: 8},
  %{name: "Kasempa", province_id: 8},
  %{name: "Manyinga", province_id: 8},
  %{name: "Mufumbwe", province_id: 8},
  %{name: "Mushindamo", province_id: 8},
  %{name: "Mwinilunga", province_id: 8},
  %{name: "Solwezi", province_id: 8},
  %{name: "Zambezi", province_id: 8},
  %{name: "Chikankata", province_id: 9},
  %{name: "Chirundu", province_id: 9},
  %{name: "Choma", province_id: 9},
  %{name: "Gwembe", province_id: 9},
  %{name: "Itezhi-Tezhi", province_id: 9},
  %{name: "Kalomo", province_id: 9},
  %{name: "Kazungula", province_id: 9},
  %{name: "Livingstone", province_id: 9},
  %{name: "Mazabuka", province_id: 9},
  %{name: "Monze", province_id: 9},
  %{name: "Namwala", province_id: 9},
  %{name: "Pemba", province_id: 9},
  %{name: "Siavonga", province_id: 9},
  %{name: "Sinazongwe", province_id: 9},
  %{name: "Zimba", province_id: 9},
  %{name: "Kalabo", province_id: 10},
  %{name: "Kaoma", province_id: 10},
  %{name: "Limulunga", province_id: 10},
  %{name: "Luampa", province_id: 10},
  %{name: "Lukulu", province_id: 10},
  %{name: "Mitete", province_id: 10},
  %{name: "Mongu", province_id: 10},
  %{name: "Mulobezi", province_id: 10},
  %{name: "Mwandi", province_id: 10},
  %{name: "Nalolo", province_id: 10},
  %{name: "Nkeyema", province_id: 10},
  %{name: "Senanga", province_id: 10},
  %{name: "Sesheke", province_id: 10},
  %{name: "Shangombo", province_id: 10},
  %{name: "Sikongo", province_id: 10},
  %{name: "Sioma", province_id: 10}
]

for i <- client_types do
TIERS.create_tier(i)
end

for i <- property_types do
TYPES.create_type(i)
end

for i <- provinces do
PROVINCES.create_province(i)
end

for i <- districts do
DISTRICT.create_district(i)
end
