defmodule Config.DevSecrets do
  def setup_env do
    System.put_env("DATABASE_USER", "postgres")
    System.put_env("DATABASE_PASSWORD", "postgres")
    System.put_env("DATABASE_HOST", "localhost")
    System.put_env("DATABASE_NAME", "timemanager_dev")
    System.put_env("PORT", "4000")
    System.put_env("JWT_PASSPHRASE", "blaaaa")
  end
end

Config.DevSecrets.setup_env()
