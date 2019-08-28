defmodule MusicDB.Exercises.SchemaExercises do
  import Ecto.Query

  alias MusicDB.{
    Artist,
    Repo,
    Track
  }

  def convert_schema_less_query do
    Artist
    |> select([a], [:name])
    |> where([a], a.birth_date >= ^~D[1990-11-15])
    |> Repo.all()
  end

  def insert_a_track! do
    # Use Repo.insert! to insert a %Track{} with whatever title and index you like.
    %Track{title: "Garry Track", index: 10}
    |> Repo.insert!()
  end

  def delete_an_album!(album) do
    album
    |> Repo.delete!()
  end
end
