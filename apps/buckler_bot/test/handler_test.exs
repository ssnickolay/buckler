defmodule BucklerBot.HandlerTest do
  use ExUnit.Case
  alias Agala.Provider.Telegram.Conn.Response
  alias BucklerBot.{Handler, Repo, Model.User}

  setup do
    Repo.start_link
    :dets.delete_all_objects(db_name())

    :ok
  end

  defp db_name, do: Application.get_env(:buckler_bot, Repo)[:db_name] |> String.to_atom

  def insert_user(%User{chat_id: chat_id, user_id: user_id}=user) do
    :dets.insert(db_name(), { {chat_id, user_id}, user })
    user
  end

  describe "when unauthorized user left the chat" do
    setup do
      insert_user(%User{chat_id: 205798533, user_id: 1})
      [conn: %Agala.Conn{
        request: %{
          "message" => %{
            "chat" => %{"id" => 205798533},
            "left_chat_member" => %{"id" => 1}
          }
        }
      }]
    end

    test "should successfully delete user from DB", %{conn: conn} do
      conn = Handler.handle(conn, [])
      assert %Response{
        method: :post,
        opts: [],
        payload: %{body: %{chat_id: 205798533, message_id: nil}}
      } = conn.response

      assert {false, :authorized} = Repo.user_unauthorized?(205798533, 1)
    end
  end

  describe "when authorized user left the chat" do
    setup do
      [conn: %Agala.Conn{
        request: %{
          "message" => %{
            "chat" => %{"id" => 205798533},
            "left_chat_member" => %{"id" => 1}
          }
        }
      }]
    end

    test "should return halt conn", %{conn: conn} do
      conn = Handler.handle(conn, [])
      assert is_nil(conn.response) == true

      assert {false, :authorized} = Repo.user_unauthorized?(205798533, 1)
    end
  end
end
