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
        email: "antoine@timemanager.com",
        hashed_password: Bcrypt.hash_pwd_salt("code1234"),
        role_id: user_role.id,
        team_id: nil
      },
      %{
        username: "Marc",
        email: "marc@timemanager.com",
        hashed_password: Bcrypt.hash_pwd_salt("code1234"),
        role_id: user_role.id,
        team_id: nil
      },
      %{
        username: "Swan",
        email: "swan@timemanager.com",
        hashed_password: Bcrypt.hash_pwd_salt("code1234"),
        role_id: manager_role.id,
        team_id: nil
      },
      %{
        username: "Laurent",
        email: "laurent@timemanager.com",
        hashed_password: Bcrypt.hash_pwd_salt("code1234"),
        role_id: supervisor_role.id,
        team_id: nil
      },
      %{
        username: "Max",
        email: "max@timemanager.com",
        hashed_password: Bcrypt.hash_pwd_salt("code1234"),
        role_id: user_role.id,
        team_id: nil
      },
      %{
        username: "Emilie",
        email: "emilie@timemanager.com",
        hashed_password: Bcrypt.hash_pwd_salt("code1234"),
        role_id: user_role.id,
        team_id: nil
      },
      %{
        username: "Rose",
        email: "rose@timemanager.com",
        hashed_password: Bcrypt.hash_pwd_salt("code1234"),
        role_id: manager_role.id,
        team_id: nil
      },
      %{
        username: "Romain",
        email: "romain@timemanager.com",
        hashed_password: Bcrypt.hash_pwd_salt("code1234"),
        role_id: user_role.id,
        team_id: nil
      },
      %{
        username: "Sophie",
        email: "sophie@timemanager.com",
        hashed_password: Bcrypt.hash_pwd_salt("code1234"),
        role_id: user_role.id,
        team_id: nil
      },
      %{
        username: "Sarah",
        email: "sarah@timemanager.com",
        hashed_password: Bcrypt.hash_pwd_salt("code1234"),
        role_id: user_role.id,
        team_id: nil
      },
      %{
        username: "Marius",
        email: "marius@timemanager.com",
        hashed_password: Bcrypt.hash_pwd_salt("code1234"),
        role_id: user_role.id,
        team_id: nil
      }
    ]
    Enum.each(users, fn user ->
      IO.puts("Creating user: #{user.username}")
      Repo.insert!(%User{
        username: user.username,
        email: user.email,
        hashed_password: user.hashed_password,
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
    antoine_id = Repo.one(from u in User, where: u.username == "Antoine", select: u.id)
    for day <- 0..21 do
      working_start = DateTime.add(~U[2024-10-07 08:00:00Z], day*86400)
      working_end = DateTime.add(~U[2024-10-07 17:00:00Z], day*86400)

      Repo.insert!(%WorkingTime{
        working_start: working_start,
        working_end: working_end,
        user_id: antoine_id
      })

      clock_in_offset = Enum.random(-300..300)
      clock_in_time = working_start |> DateTime.add(clock_in_offset)

      clock_out_offset = Enum.random(-300..300)
      clock_out_time = working_end |> DateTime.add(clock_out_offset)

      Repo.insert!(%Clock{
        user_id: antoine_id,
        time: clock_in_time,
        status: true
      })
      Repo.insert!(%Clock{
        user_id: antoine_id,
        time: clock_out_time,
        status: false
      })
    end

    Repo.insert!(%WorkingTime{
      working_start: ~U[2024-10-28 08:00:00Z],
      working_end: ~U[2024-10-28 17:00:00Z],
      user_id: 1
    })

    Repo.insert!(%Clock{
      user_id: 1,
      time: ~U[2024-10-29 08:50:00Z],
      status: true
    })

    Repo.insert!(%Clock{
      user_id: 1,
      time: ~U[2024-10-29 17:30:00Z],
      status: false
    })

    Repo.insert!(%WorkingTime{
      working_start: ~U[2024-10-29 08:00:00Z],
      working_end: ~U[2024-10-29 17:00:00Z],
      user_id: 1
    })

    Repo.insert!(%Clock{
      user_id: 1,
      time: ~U[2024-10-29 08:50:00Z],
      status: true
    })

    Repo.insert!(%Clock{
      user_id: 1,
      time: ~U[2024-10-29 12:30:00Z],
      status: false
    })
  end
end

Timemanager.Seeds.run()
