use Mix.Config

config :music_db, MusicDB.Repo,
  database: "music_db_workshop_test",
  username: System.get_env("DATABASE_USERNAME") || "postgres",
  password: System.get_env("DATABASE_PASSWORD") || "postgres",
  port: 5430,
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox,
  ownership_timeout: 60_000

