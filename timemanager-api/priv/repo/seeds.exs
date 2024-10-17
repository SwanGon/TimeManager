# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Timemanager.Repo.insert!(%Timemanager.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Timemanager.Repo
alias Timemanager.RoleManager.Role
alias Timemanager.UserManager.User
alias Timemanager.ClockManager.Clock
alias Timemanager.WorkingTimeManager.WorkingTime

IO.puts("deleting previous working users and associated...")
Repo.delete_all Clock
Repo.delete_all WorkingTime
Repo.delete_all User
Repo.delete_all Role
# # Then we create users with:

user_role = Repo.insert! %Role{
  title: "user"
}

admin_role =Repo.insert! %Role{
  title: "admin"
}


supervisor_role = Repo.insert! %Role{
  title: "supervisor"
}

antoine = Repo.insert! %User{
  username: "Antoine",
  email: "antoine@mail.mail",
  role_id: supervisor_role.id
}

marc = Repo.insert! %User{
  username: "Marc",
  email: "marc@mail.mail",
  role_id: user_role.id
}


swan = Repo.insert! %User{
  username: "Swan",
  email: "swan@mail.mail",
  role_id: admin_role.id
}



Repo.insert! %WorkingTime{
  working_start: ~U[2024-10-08 09:00:00Z],
  working_end: ~U[2024-10-08 17:00:00Z],
  user_id: antoine.id
}

Repo.insert! %WorkingTime{
  working_start: ~U[2024-10-08 09:00:00Z],
  working_end: ~U[2024-10-08 17:00:00Z],
  user_id: marc.id
}

Repo.insert! %WorkingTime{
  working_start: ~U[2024-10-08 09:00:00Z],
  working_end: ~U[2024-10-08 17:00:00Z],
  user_id: swan.id
}






# IO.puts("managing working times...")

clocks_antoine = [
  %{time: ~U[2024-10-08 09:05:23Z],status: true, user_id: antoine.id},
  %{time: ~U[2024-10-08 17:10:33Z],status: false,user_id: antoine.id},
  %{time: ~U[2024-10-09 08:50:12Z],status: true, user_id: antoine.id},
  %{time: ~U[2024-10-09 16:40:45Z],status: false,user_id: antoine.id},
]

clocks_swan = [
  %{time: ~U[2024-10-08 09:01:30Z],status: true, user_id: swan.id},
  %{time: ~U[2024-10-08 17:02:04Z],status: false,user_id: swan.id},
  %{time: ~U[2024-10-09 08:30:01Z],status: true, user_id: swan.id},
  %{time: ~U[2024-10-09 16:45:30Z],status: false,user_id: swan.id},
]

clocks_marc = [
  %{time: ~U[2024-10-08 10:09:00Z],status: true, user_id: marc.id},
  %{time: ~U[2024-10-08 18:00:23Z],status: false,user_id: marc.id},
  %{time: ~U[2024-10-09 09:12:00Z],status: true, user_id: marc.id},
  %{time: ~U[2024-10-09 17:45:12Z],status: false,user_id: marc.id},
]


Enum.each([clocks_antoine,clocks_marc,clocks_swan], fn clocks ->
  Enum.each(clocks, fn clock ->
    IO.puts("creating clock...")
    Repo.insert! %Clock{
      time: clock.time,
      status: clock.status,
      user_id: clock.user_id
    }
  end
  )
end
)
