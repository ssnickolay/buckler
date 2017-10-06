defmodule DB.ConnectionsTest do
  use DB.ModelCase
  alias DB.{Customer, Chat, Connections}

  test "#get_chatuser should return %Customer{}" do
    user = create_customer()
    %{user_id: user_id, chat_id: chat_id} = user

    assert %Customer{} = Connections.get_chatuser(chat_id, user_id)
  end

  test "#get_or_create_chat should return persisted chat" do
    chat = create_chat()
    assert Connections.get_or_create_chat(chat.id) == {:ok, chat}
  end

  test "#get_or_create_chat should create new chat" do
    assert {:ok, %Chat{id: 123}} = Connections.get_or_create_chat(123)
  end

  test "#connect_user should create new Customer" do
    assert {:ok, %Customer{
      name: "John",
      user_id: 123,
      connected_message_id: 456,
      lang: "en",
      attempts: 3,
      chat_id: 789
    }} = Connections.connect_user(789, 123, "John", "answer", 456)
    assert %Chat{} = Repo.get(Chat, 789)
  end
end
