defmodule DB.ConnectionsTest do
  use DB.ModelCase
  alias DB.{Customer, Chat, Connections}

  test "#get_chatuser should return %Customer{}" do
    customer = create_customer()
    %{user_id: user_id, chat_id: chat_id} = customer

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

  test "#decrease_attempts" do
    customer = create_customer()
    assert customer.attempts == 3
    assert {:ok, %Customer{
      attempts: 2,
      answer: "another answer"
    }} = Connections.decrease_attempts(customer.chat_id, customer.user_id, "another answer")
  end

  test "#delete_chatuser" do
    customer = create_customer()
    Connections.delete_chatuser(customer.chat_id, customer.user_id)

    assert is_nil(Connections.get_chatuser(customer.chat_id, customer.user_id))
  end

  test "#user_unauthorized? when user exists" do
    customer = create_customer()
    assert Connections.user_unauthorized?(customer.chat_id, customer.user_id)
  end

  test "#user_unauthorized? when user non exists" do
    refute Connections.user_unauthorized?(1, 2)
  end
end
