defmodule RentalPropertyWeb.ViewUsersComponent do
  use RentalPropertyWeb, :live_component
  alias RentalProperty.USERS
  alias RentalProperty.ROLES
  

  def update(assigns, socket) do
    users = for user <- USERS.list_users do
      Map.from_struct(user)
    end
    roles = for user <- users do
      ROLES.get_role!(user.role_id) |> Map.from_struct()
    end
    users_with_role = for user <- users do
      Map.put(user, :role, Enum.at(roles, user.id - 1))
    end
    IO.inspect(roles, label: "ROLES--->")
    socket = socket
    |> assign(:users, users_with_role)
    {:ok, socket}
  end


  def render(assigns) do
   ~H"""


<div class="relative overflow-x-auto">
    <button phx-click="close_view_users">
<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
  <path stroke-linecap="round" stroke-linejoin="round" d="M6 18 18 6M6 6l12 12" />
</svg>

    </button>
    <table class="w-full text-sm text-left rtl:text-right text-gray-500 dark:text-gray-400">
        <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
            <tr>
                <th scope="col" class="px-6 py-3">
                  First name
                </th>
                <th scope="col" class="px-6 py-3">
                  Last name 
                </th>
                <th scope="col" class="px-6 py-3">
                  Gender 
                </th>
                <th scope="col" class="px-6 py-3">
                  Phone number 
                </th>
                 <th scope="col" class="px-6 py-3">
                  Role 
                </th>
                
            </tr>
        </thead>
        <tbody>
          <%= for user <- @users do %>
            <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700 border-gray-200">
                <th scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                 <%= user.fname %> 
                </th>
                <td class="px-6 py-4">
                  <%= user.lname %> 
                </td>
                <td class="px-6 py-4">
                  <%= user.gender %> 
                </td>
                <td class="px-6 py-4">
                  <%= user.phone %>  
                </td>
                <td class="px-6 py-4">
                 <%= user.role.name %> 
                </td>

            </tr>
          <% end %>
      </tbody>
    </table>
</div>

   """
  end



end
