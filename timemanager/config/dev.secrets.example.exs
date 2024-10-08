defmodule Config.DevSecrets do
  def setup_env do
    System.put_env("DATABASE_USER", "change_me")
    System.put_env("DATABASE_PASSWORD", "change_me")
    System.put_env("DATABASE_HOST", "change_me")
    System.put_env("DATABASE_NAME", "change_me")
    System.put_env("PORT", "42")
  end
end

Config.DevSecrets.setup_env()
