use Mix.Config

config :buckler_bot, :telegram,
  token: "123"

config :buckler_bot, BucklerBot.Repo,
  db_name: "testdb"
