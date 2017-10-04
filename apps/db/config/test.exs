use Mix.Config

config :db, DB.Repo,
  adapter: Ecto.Adapters.Postgres,
  pool: Ecto.Adapters.SQL.Sandbox,
  database: "buckler_test",
  username: System.get_env("BUCKLER_SQL_USER"),
  password: System.get_env("BUCKLER_PASS"),
  hostname: System.get_env("BUCKLER_HOST"),
  timeout: :infinity,
  pool_timeout: :infinity,
  ownership_timeout: :infinity

config :logger,
  level: :info
