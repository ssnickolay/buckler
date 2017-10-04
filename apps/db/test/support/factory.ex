defmodule DB.Factory do
  alias DB.{Customer, Chat, Repo, Connections}

  def create_customer(_options \\ %{}) do
    %Customer{
      name: "Adam Moris",
      user_id: 4321,
      connected_message_id: 3123,
      welcome_message_id: 3122,
      answer: "20",
      lang: "ru",
      attempts: 3,
      chat: %Chat{id: 123456, lang: "ru", attempts: 3}
    } |> Repo.insert!
  end
end