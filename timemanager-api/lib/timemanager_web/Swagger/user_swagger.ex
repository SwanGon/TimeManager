defmodule TimemanagerWeb.Swagger.UserSwagger do
  use PhoenixSwagger
  def swagger_definitions do
    %{
      User: swagger_schema do
        title "User"
        description "User details"
        properties do
          username :string, "Username"
          email :string, "Email address"
          role_id :integer, "Role ID"
        end
        example %{
          username: "JohnDoe123",
          email: "mymail@testmail.com",
          role_id: 1
        }
      end,
      CreateUser: swagger_schema do
        title "Create User"
        description "Schema for creating a user"
        properties do
          username :string, "Username", example: "JohnDoe123", required: true
          email :string, "Email address", example: "mymail@testmail.com", required: true
          role_id :integer, "Role id", example: 1, required: true, default: 1
        end
      end,
      UpdateUser: swagger_schema do
        title "Update User"
        description "Schema for updating a user"
        properties do
          username :string, "Username", example: "UpdatedUser123", required: true
          email :string, "Email address", example: "updatedmail@testmail.com", required: true
          role_id :integer, "Role id", example: 1, required: true, default: 1
        end
      end,
    }
  end

  def paths do
    quote do
      swagger_path :index do
        get "/api/users"
        description "List all users, can pass email or username as params"
        produces "application/json"
        tag "Users"
        parameters do
          email :query, :string, "Email address of the user", required: false, default: "antoine@timemanager.com"
          username :query, :string, "Username of the user", required: false, default: "Antoine"
        end
        response 200, "Success"
        response 400, "Client Error"
      end

      swagger_path :managers do
        get "/api/managers"
        description "List all users with manager Role"
        produces "application/json"
        tag "Users"
        response 200, "Success"
        response 400, "Client Error"
      end

      swagger_path :supervisors do
        get "/api/supervisors"
        description "List all users with supervisor Role"
        produces "application/json"
        tag "Users"
        response 200, "Success"
        response 400, "Client Error"
      end

      swagger_path :show do
        get "/api/users/{id}"
        description "Get user by id"
        produces "application/json"
        tag "Users"
        parameter :id, :path, :integer, "User ID", required: true, default: 1
        response 200, "Success"
        response 400, "Client Error"
        response 404, "No user found with this ID"
      end

      swagger_path :create do
        post "/api/users"
        description "Create user with register"
        produces "application/json"
        tag "Users"
        parameter :username, :query, :string, "Username", default: "JohnDoe123", required: true
        parameter :email, :query, :string, "Email address", default: "mymail@testmail.com", required: true
        parameter :role_id, :query, :integer, "Role id", default: 1, required: true, default: 1
        response 201, "Success"
        response 400, "Client Error"
      end

      swagger_path :create do
        post "/api/users/register"
        description "Create user"
        produces "application/json"
        tag "Users"
        parameter :username, :query, :string, "Username", default: "JohnDoe123", required: true
        parameter :email, :query, :string, "Email address", default: "mymail@testmail.com", required: true
        parameter :role_id, :query, :integer, "Role id", default: 1, required: true, default: 1
        response 201, "Success"
        response 400, "Client Error"
      end

      swagger_path :update do
        put "/api/users/{id}"
        description "Update an existing user"
        produces "application/json"
        tag "Users"
        parameter :id, :path, :integer, "User ID", required: true, example: 3
        parameter :username, :query, :string, "Username", default: "JohnDoe123", required: true
        parameter :email, :query, :string, "Email address", default: "mymail@testmail.com", required: true
        parameter :role_id, :query, :integer, "Role id", default: 1, required: true, default: 1
        response 200, "User updated"
        response 400, "Client Error"
      end

      swagger_path :delete do
        PhoenixSwagger.Path.delete "/api/users/{id}"
        description "Delete a user by ID"
        tag "Users"
        parameter :id, :path, :integer, "User ID", required: true, example: 3
        response 204, "No Content - Deleted Successfully"
      end
    end
  end
end
