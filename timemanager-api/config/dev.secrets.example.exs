defmodule Config.DevSecrets do
  def setup_env do
    System.put_env("DATABASE_USER", "replace_it")
    System.put_env("DATABASE_PASSWORD", "replace_it")
    System.put_env("DATABASE_HOST", "replace_it")
    System.put_env("DATABASE_NAME", "replace_it")
    System.put_env("JWT_PASSPHRASE", "replace_it")
  end
end

Config.DevSecrets.setup_env()
