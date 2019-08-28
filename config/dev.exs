use Mix.Config

config :music_db, MusicDB.Repo,
  database: "music_db_workshop_dev",
  username: System.get_env("DATABASE_USERNAME") || "postgres",
  password: System.get_env("DATABASE_PASSWORD") || "postgres",
  port: 5430,
  hostname: "localhost"

