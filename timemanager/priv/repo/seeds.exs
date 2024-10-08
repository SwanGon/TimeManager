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

alias Timemanager.UserManager
alias Timemanager.Repo
alias Timemanager.UserManager.User
alias Timemanager.ClockManager.Clock
# alias Timemanager.WorkingTimes

# First we clean the previous seeds if there's any:

Repo.delete_all Clock
Repo.delete_all User

# # Then we create users with:

IO.puts("creating users...")

antoine = Repo.insert! %User{
  username: "Antoine",
  email: "antoine@mail.mail"
}

marc = Repo.insert! %User{
  username: "Marc",
  email: "marc@mail.mail"
}

swan = Repo.insert! %User{
  username: "Swan",
  email: "swan@mail.mail"
}

laurent = Repo.insert! %User{
  username: "Laurent",
  email: "laurent@mail.mail"
}

users = [antoine, marc, swan, laurent]
# IO.puts(UserManager.list_users())


# Then we create clock times for each users


IO.puts("creating working times...")

clock_entries = [

  # Antoine's clock
  %{time: ~U[2024-10-08 09:05:23Z],status: true, user_id: antoine.id},  # Clock in
  %{time: ~U[2024-10-08 17:10:33Z],status: false,user_id:  antoine.id}, # Clock out
  %{time: ~U[2024-10-09 08:50:12Z],status: true, user_id: antoine.id},  # Clock in
  %{time: ~U[2024-10-09 16:40:45Z],status: false,user_id:  antoine.id},  # Clock out

  # Swan's clock
  %{time: ~U[2024-10-08 09:01:30Z],status: true, user_id: swan.id},  # Clock in
  %{time: ~U[2024-10-08 17:02:04Z],status: false,user_id:  swan.id}, # Clock out
  %{time: ~U[2024-10-09 08:30:01Z],status: true, user_id: swan.id},  # Clock in
  %{time: ~U[2024-10-09 16:45:30Z],status: false,user_id:  swan.id}, # Clock out

  # Marc's clock
  %{time: ~U[2024-10-08 10:09:00Z],status: true, user_id: marc.id},  # Clock in
  %{time: ~U[2024-10-08 18:00:23Z],status: false,user_id:  marc.id}, # Clock out
  %{time: ~U[2024-10-09 09:12:00Z],status: true, user_id: marc.id},  # Clock in
  %{time: ~U[2024-10-09 17:45:12Z],status: false,user_id:  marc.id}, # Clock out

  # Laurent's clock
  %{time: ~U[2024-10-08 08:45:02Z],status: true, user_id: laurent.id},  # Clock in
  %{time: ~U[2024-10-08 15:00:30Z],status: false,user_id:  laurent.id}, # Clock out
  %{time: ~U[2024-10-09 09:15:01Z],status: true, user_id: laurent.id},  # Clock in
  %{time: ~U[2024-10-09 16:30:10Z],status: false,user_id:  laurent.id} # Clock out
]


# creating Clocks for each user
Enum.each(clock_entries, fn(clock) ->
  Repo.insert! %Clock{
    time: clock.time,
    status: clock.status,
    user_id: clock.user_id
  }

  IO.puts("creating clock #{clock.time}..")
end)

# creating Working times based on Clocks
