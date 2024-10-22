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
import Ecto.Query

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
  hashed_password: Bcrypt.hash_pwd_salt("antoine"),
  team_id: nil
}

marc = Repo.insert! %User{
  username: "Marc",
  email: "marc@mail.mail",
  role_id: user_role.id,
  hashed_password: Bcrypt.hash_pwd_salt("marc"),
  team_id: nil
}


swan = Repo.insert! %User{
  username: "Swan",
  email: "swan@mail.mail",
  role_id: manager_role.id,
  hashed_password: Bcrypt.hash_pwd_salt("swan"),
  team_id: nil
}

laurent = Repo.insert! %User{
  username: "Laurent",
  email: "laurent@mail.mail",
  role_id: user_role.id,
  hashed_password: Bcrypt.hash_pwd_salt("laurent"),
  team_id: nil
}

max = Repo.insert! %User{
  username: "Max",
  email: "max@mail.mail",
  role_id: user_role.id,
  hashed_password: Bcrypt.hash_pwd_salt("max"),
  team_id: nil
}

emilie = Repo.insert! %User{
  username: "Emilie",
  email: "emilie@mail.mail",
  role_id: user_role.id,
  hashed_password: Bcrypt.hash_pwd_salt("emilie"),
  team_id: nil
}

rose = Repo.insert! %User{
  username: "Rose",
  email: "rose@mail.mail",
  role_id: manager_role.id,
  hashed_password: Bcrypt.hash_pwd_salt("rose"),
  team_id: nil
}

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
defp create_teams do
  manager_role_id = Repo.one(from r in Role, where: r.title == "manager", select: r.id)
  managers = Repo.all(from u in User, where: u.role_id == ^manager_role_id)
  Enum.each(managers, fn manager ->
    team = Repo.insert!(%Team{manager_id: manager.id})
    IO.puts("Created team with ID #{team.id} for manager #{manager.username}")
  end)
  assign_users_to_team()
end

defp assign_users_to_team() do
  role_id = Repo.one(from r in Role, where: r.title == "user", select: r.id)
  users = Repo.all(from u in User, where: u.role_id == ^role_id and is_nil(u.team_id))
  team_ids = Repo.all(from t in Team, select: t.id)
  Enum.each(users, fn user ->
    updated_user = Ecto.Changeset.change(user, team_id: Enum.random(team_ids))
    Repo.update(updated_user)
  end
  )
end


defp create_working_times do

  working_hours_ranges = [
    {9, 17},
    {15, 23},
    {3, 11}
  ]
  teams = Repo.all(Team)

  start_of_week = Date.utc_today() |> Date.beginning_of_week(:monday)

  Enum.each(teams, fn team ->

    users = Repo.all(from u in User, where: u.team_id == ^team.id)

    {start_hour, end_hour} = Enum.at(working_hours_ranges, rem(team.id - 1, length(working_hours_ranges)))

    for day <- 0..5 do
      working_start = DateTime.utc_now() |> DateTime.truncate(:second) |> DateTime.add(day * 86400) |> DateTime.add(start_hour * 3600)
      working_end = working_start |> DateTime.add(8 * 3600)

      Enum.each(users, fn user ->
        Repo.insert!(%WorkingTime{
          working_start: working_start,
          working_end: working_end,
          user_id: user.id
        })

        clock_in_offset = Enum.random([-300, 300])
        clock_in_time = working_start |> DateTime.add(clock_in_offset)

        clock_out_offset = Enum.random([-300, 300])
        clock_out_time = working_end |> DateTime.add(clock_out_offset)

        Repo.insert!(%Clock{
          user_id: user.id,
          time: clock_in_time,
          status: true
        })

        Repo.insert!(%Clock{
          user_id: user.id,
          time: clock_out_time,
          status: false
        })
      end)
      IO.puts("Created working time for team #{team.id} from #{working_start} to #{working_end}")
    end
  end)
end


)
