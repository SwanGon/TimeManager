defmodule Timemanager.JWTToken do
  use Joken.Config
  def token_config do
    default_claims(default_exp: 60 * 60 * 24 * 30) # 30 days
    |> add_claim("user_id", nil, &(&1>0))
    |> add_claim("role", nil, &(&1 in ["user", "manager", "supervisor"]))
  end

  def generate_user_token(user) do
    extra_claims = %{"user_id" => user.id, "role" => user.role_id}
    signer = signer()
    generate_and_sign!(extra_claims, signer)
  end


  def verify_token(token) do
    verify_and_validate(token)
  end
  def signer do
    secret = Application.get_env(:timemanager, Timemanager.JWTToken)[:secret_key]
    Joken.Signer.create("HS256", secret)
  end
end
