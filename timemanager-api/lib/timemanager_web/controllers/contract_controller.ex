defmodule TimemanagerWeb.ContractController do
  use TimemanagerWeb, :controller

  def index(conn, _params) do
    contract_path = Path.join(["assets", "contract", "Contrat de travail.pdf"])
    file = File.read!(contract_path)
    conn
    |> put_resp_content_type("application/pdf")
    |> send_resp(200, file)
  end
end