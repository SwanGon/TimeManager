alias Postgrex.Extensions.Time
alias Timemanager.Repo
alias Timemanager.TeamManagers.Team
alias Timemanager.RoleManager.Role
alias Timemanager.UserManager.User
alias Timemanager.ClockManager.Clock
alias Timemanager.WorkingTimeManager.WorkingTime
import Ecto.Query


defmodule Timemanager.Seeds do

  Repo.delete_all Clock
  Repo.delete_all WorkingTime
  Repo.delete_all Team
  Repo.delete_all User
  Repo.delete_all Role

  def run do
    create_users()
    create_teams()
    create_working_times()
    # create_clocks()
  end

  defp create_roles do
    user_role = Repo.insert!(%Role{title: "user"})
    manager_role = Repo.insert!(%Role{title: "manager"})
    supervisor_role = Repo.insert!(%Role{title: "supervisor"})

    {user_role, manager_role, supervisor_role}
  end

  defp create_users do
    {user_role, manager_role, supervisor_role} = create_roles()
    users = [
      %{
        username: "Antoine",
        email: "antoine@mail.mail",
        role_id: supervisor_role.id,
        team_id: nil
      },
      %{
        username: "Marc",
        email: "marc@mail.mail",
        role_id: user_role.id,
        team_id: nil
      },
      %{
        username: "Swan",
        email: "swan@mail.mail",
        role_id: manager_role.id,
        team_id: nil
      },
      %{
        username: "Laurent",
        email: "laurent@mail.mail",
        role_id: supervisor_role.id,
        team_id: nil
      },
      %{
        username: "Max",
        email: "max@mail.mail",
        role_id: user_role.id,
        team_id: nil
      },
      %{
        username: "Emilie",
        email: "emilie@mail.mail",
        role_id: user_role.id,
        team_id: nil
      },
      %{
        username: "Rose",
        email: "rose@mail.mail",
        role_id: manager_role.id,
        team_id: nil
      },
      %{
        username: "Romain",
        email: "romain@mail.mail",
        role_id: user_role.id,
        team_id: nil
      },
      %{
        username: "Sophie",
        email: "sophie@mail.mail",
        role_id: user_role.id,
        team_id: nil
      },
      %{
        username: "Sarah",
        email: "sarah@mail.mail",
        role_id: user_role.id,
        team_id: nil
      },
      %{
        username: "Marius",
        email: "marius@mail.mail",
        role_id: user_role.id,
        team_id: nil
      }
    ]
    Enum.each(users, fn user ->
      IO.puts("Creating user: #{user.username}")
      Repo.insert!(%User{
        username: user.username,
        email: user.email,
        role_id: user.role_id,
        team_id: nil
      })
    end)
  end

  defp create_teams do
    manager_role_id = Repo.one(from r in Role, where: r.title == "manager", select: r.id)
    managers = Repo.all(from u in User, where: u.role_id == ^manager_role_id)
    Enum.each(managers, fn manager ->
      team = Repo.insert!(%Team{manager_id: manager.id})
      IO.puts("Created team with ID #{team.id} for manager #{manager.username}")
      assign_users_to_team(team.id)
    end)
  end

  defp assign_users_to_team(team_id) do
    role_id = Repo.one(from r in Role, where: r.title == "user", select: r.id)
    users = Repo.all(from u in User, where: u.role_id == ^role_id and is_nil(u.team_id))
    Enum.each(users, fn user ->
      updated_user = Ecto.Changeset.change(user, team_id: team_id)
      case Repo.update(updated_user) do
        {:ok, _user} ->
          IO.puts("Assigned user #{user.username} to team with ID #{team_id}")
        {:error, changeset} ->
          IO.puts("Failed to assign user #{user.username}: #{inspect(changeset.errors)}")
      end
    end)
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

        end)

        IO.puts("Created working time for team #{team.id} from #{working_start} to #{working_end}")
      end
    end)
  end
end

Timemanager.Seeds.run()
