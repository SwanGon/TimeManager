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

alias Bandit.Clock
alias Timemanager.Repo
alias Timemanager.UserManager.User
alias Timemanager.RoleManager.Role
# alias Timemanager.ClockManager.Clock
# alias Timemanager.WorkingTimeManager.WorkingTime

IO.puts("deleting previous working users and associated...")
# Repo.delete_all WorkingTime
# Repo.delete_all CLock
Repo.delete_all User

Repo.insert! %Role{
  title: "user"
}

Repo.insert! %Role{
  title: "admin"
}

Repo.insert! %Role{
  title: "supervisor"
}

IO.puts("creating users Antoine...")

Repo.insert! %User{
  username: "Antoine",
  email: "antoine@mail.mail",
  role_id: 1
}

IO.puts("creating users Marc...")


Repo.insert! %User{
  username: "Marc",
  email: "marc@mail.mail",
  role_id: 1
}

IO.puts("creating users Swan...")

Repo.insert! %User{
  username: "Swan",
  email: "swan@mail.mail",
  role_id: 1
}

IO.puts("creating users Laurent...")

Repo.insert! %User{
  username: "Laurent",
  email: "laurent@mail.mail",
  role_id: 1
}
