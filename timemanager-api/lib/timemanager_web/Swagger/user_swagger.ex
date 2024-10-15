defmodule TimemanagerWeb.Swagger.UserSwagger do
  use PhoenixSwagger

  def swagger_definitions do
    %{
      CreateUser: swagger_schema do
        title "Create User"
        description "Schema for creating a user"
        properties do
          username :string, "Username", example: "JohnDoe123", required: true
          email :string, "Email address", example: "mymail@testmail.com", required: true
        end
      end,
      User: swagger_schema do
        title "User"
        description "User details"
        properties do
          username :string, "Username"
          email :string, "Email address"
        end
        example %{
          username: "JohnDoe123",
          email: "mymail@testmail.com"
        }
      end,
      UpdateUser: swagger_schema do
        title "Update User"
        description "Schema for updating a user"
        properties do
          username :string, "Username", example: "UpdatedUser123", required: true
          email :string, "Email address", example: "updatedmail@testmail.com", required: true
        end
      end,
    }
  end

  def paths do
    quote do
      swagger_path :index do
        get "/api/users"
        description "List all users"
        produces "application/json"
        tag "Users"
        response 200, "Success"
        response 400, "Client Error"
      end

      swagger_path :create do
        post "/api/users"
        description "Create user"
        produces "application/json"
        tag "Users"
        parameters do
          body :body, Schema.ref(:CreateUser), "User creation params", required: true
        end
        response 201, "Success", Schema.ref(:User)
        response 400, "Client Error"
      end

      swagger_path :show do
        get "/api/users/{id}"
        description "Get user by id"
        produces "application/json"
        tag "Users"
        parameter :id, :path, :integer, "User ID", required: true, example: 3
        response 200, "Success"
        response 400, "Client Error"
      end

      swagger_path :update do
        put "/api/users/{id}"
        description "Update an existing user"
        produces "application/json"
        tag "Users"
        parameters do
          id :path, :integer, "User ID", required: true, example: 1
          body :body, Schema.ref(:UpdateUser), "User update params", required: true
        end
        response 200, "User updated", Schema.ref(:User)
        response 400, "Client Error"
      end

      swagger_path :delete do
        PhoenixSwagger.Path.delete "/api/users/{id}"
        summary "Delete User"
        description "Delete a user by ID"
        tag "Users"
        parameter :id, :path, :integer, "User ID", required: true, example: 3
        response 204, "No Content - Deleted Successfully"
      end
    end
  end
end
