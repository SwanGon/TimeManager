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
alias Timemanager.TeamManagers.Team
alias Timemanager.RoleManager.Role
alias Timemanager.UserManager.User
alias Timemanager.ClockManager.Clock
alias Timemanager.WorkingTimeManager.WorkingTime

IO.puts("deleting previous working users and associated...")
Repo.delete_all Clock
Repo.delete_all WorkingTime
Repo.delete_all Team
Repo.delete_all User
Repo.delete_all Role
# # Then we create users with:



user_role = Repo.insert! %Role{
  title: "user"
}

manager_role =Repo.insert! %Role{
  title: "manager"
}


supervisor_role = Repo.insert! %Role{
  title: "supervisor"
}

antoine = Repo.insert! %User{
  username: "Antoine",
  email: "antoine@mail.mail",
  role_id: supervisor_role.id,
  team_id: nil
}

marc = Repo.insert! %User{
  username: "Marc",
  email: "marc@mail.mail",
  role_id: user_role.id,
  team_id: nil
}


swan = Repo.insert! %User{
  username: "Swan",
  email: "swan@mail.mail",
  role_id: manager_role.id,
  team_id: nil
}

laurent = Repo.insert! %User{
  username: "Laurent",
  email: "laurent@mail.mail",
  role_id: user_role.id,
  team_id: nil
}

max = Repo.insert! %User{
  username: "Max",
  email: "max@mail.mail",
  role_id: user_role.id,
  team_id: nil
}

emilie = Repo.insert! %User{
  username: "Emilie",
  email: "emilie@mail.mail",
  role_id: user_role.id,
  team_id: nil
}

rose = Repo.insert! %User{
  username: "Rose",
  email: "rose@mail.mail",
  role_id: manager_role.id,
  team_id: nil
}


team1 = Repo.insert! %Team{
  manager_id: rose.id
}

team2 = Repo.insert! %Team{
  manager_id: swan.id
}

emilie = Repo.update!(Ecto.Changeset.change(emilie, team_id: team1.id))
max = Repo.update!(Ecto.Changeset.change(max, team_id: team1.id))
laurent = Repo.update!(Ecto.Changeset.change(laurent, team_id: team2.id))
marc = Repo.update!(Ecto.Changeset.change(marc, team_id: team2.id))

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

Repo.insert! %WorkingTime{
  working_start: ~U[2024-10-08 09:00:00Z],
  working_end: ~U[2024-10-08 17:00:00Z],
  user_id: laurent.id
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

clocks_laurent = [
  %{time: ~U[2024-10-08 10:09:00Z],status: true, user_id: laurent.id},
  %{time: ~U[2024-10-08 18:00:23Z],status: false,user_id: laurent.id},
  %{time: ~U[2024-10-09 09:12:00Z],status: true, user_id: laurent.id},
  %{time: ~U[2024-10-09 17:45:12Z],status: false,user_id: laurent.id},
]


Enum.each([clocks_antoine,clocks_marc,clocks_swan,clocks_laurent], fn clocks ->
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


