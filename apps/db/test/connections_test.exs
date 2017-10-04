defmodule DB.ConnectionsTest do
  use DB.ModelCase
  alias DB.{Customer, Chat, Repo, Connections}

  test "get_chatuser" do
    user = create_customer()
    %{user_id: user_id, chat_id: chat_id} = user

    assert %Customer{} = Connections.get_chatuser(chat_id, user_id)
  end
end
