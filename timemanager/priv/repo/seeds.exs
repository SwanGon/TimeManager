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
alias Timemanager.UserManager.User
alias Timemanager.ClockManager.Clock
alias Timemanager.WorkingTimeManager.WorkingTime

# First we clean the previous seeds if there is any:
IO.puts("deleting previous working times...")
Repo.delete_all WorkingTime
IO.puts("deleting previous working clocks...")
Repo.delete_all Clock
IO.puts("deleting previous working users...")
Repo.delete_all User

# # Then we create users with:

IO.puts("creating users Antoine...")

antoine = Repo.insert! %User{
  username: "Antoine",
  email: "antoine@mail.mail"
}

IO.puts("creating users Marc...")


marc = Repo.insert! %User{
  username: "Marc",
  email: "marc@mail.mail"
}

IO.puts("creating users Swan...")

swan = Repo.insert! %User{
  username: "Swan",
  email: "swan@mail.mail"
}

IO.puts("creating users Laurent...")

laurent = Repo.insert! %User{
  username: "Laurent",
  email: "laurent@mail.mail"
}

# Then we create clock times for each users


IO.puts("managing working times...")

clocks_antoine = [
  %{time: ~U[2024-10-08 09:05:23Z],status: true, user_id: antoine.id},
  %{time: ~U[2024-10-08 17:10:33Z],status: false,user_id:  antoine.id},
  %{time: ~U[2024-10-09 08:50:12Z],status: true, user_id: antoine.id},
  %{time: ~U[2024-10-09 16:40:45Z],status: false,user_id:  antoine.id},
]

clocks_swan = [
  %{time: ~U[2024-10-08 09:01:30Z],status: true, user_id: swan.id},
  %{time: ~U[2024-10-08 17:02:04Z],status: false,user_id:  swan.id},
  %{time: ~U[2024-10-09 08:30:01Z],status: true, user_id: swan.id},
  %{time: ~U[2024-10-09 16:45:30Z],status: false,user_id:  swan.id},
]

clocks_marc = [
  %{time: ~U[2024-10-08 10:09:00Z],status: true, user_id: marc.id},
  %{time: ~U[2024-10-08 18:00:23Z],status: false,user_id:  marc.id},
  %{time: ~U[2024-10-09 09:12:00Z],status: true, user_id: marc.id},
  %{time: ~U[2024-10-09 17:45:12Z],status: false,user_id:  marc.id},
]

clocks_laurent = [
  %{time: ~U[2024-10-08 08:45:02Z],status: true, user_id: laurent.id},
  %{time: ~U[2024-10-08 15:00:30Z],status: false,user_id:  laurent.id},
  %{time: ~U[2024-10-09 09:15:01Z],status: true, user_id: laurent.id},
  %{time: ~U[2024-10-09 16:30:10Z],status: false,user_id:  laurent.id}
]

Enum.each([clocks_antoine,clocks_laurent,clocks_marc,clocks_swan], fn clocks ->
  Enum.each(Enum.with_index(clocks), fn{clock, index} ->
    IO.puts("creating clock...")
    Repo.insert! %Clock{
      time: clock.time,
      status: clock.status,
      user_id: clock.user_id
    }
    if clock.status == false do
      Repo.insert! %WorkingTime{
        start: Enum.at(clocks_antoine, index - 1).time,
        end: clock.time,
        user_id: clock.user_id
      }
      IO.puts("creating working times...")
    end
  end)
end
)
