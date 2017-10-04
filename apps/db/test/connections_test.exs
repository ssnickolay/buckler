defmodule DB.ConnectionsTest do
  use DB.ModelCase
  alias DB.{Customer, Chat, Repo, Connections}

  test "get_chatuser should return %Customer{}" do
    user = create_customer()
    %{user_id: user_id, chat_id: chat_id} = user

    IO.puts(inspect(Repo.all(Customer)))
    assert %Customer{} = Connections.get_chatuser(chat_id, user_id)
  end

  test "get_or_create_chat should return persisted chat" do
    chat = create_chat()
    assert Connections.get_or_create_chat(chat.id) == chat
  end

  test "get_or_create_chat should create new chat" do
    chat_id = 123
    assert %Chat{id: 123} = Connections.get_or_create_chat(123)
  end
end
