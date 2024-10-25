defmodule TimemanagerWeb.SessionJSON do
  @doc """
  Renders a token.
  """
  def token(%{user: user, token: token, csrf_token: token_csrf}) do
    %{
      user: %{
        id: user.id,
        username: user.username,
        email: user.email,
        role_id: user.role_id
      },
      token: token,
      csrf_token: token_csrf
    }
  end

  @doc """
  Renders an error message.
  """
  def error(%{message: message}) do
    %{error: message}
  end
end
