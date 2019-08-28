defmodule MusicDB.Exercises.QueryExercises do
  import Ecto.Query

  alias MusicDB.Repo

  def simplest_query do
    # Need to use an atom to ensure it came back as a map, otherwise it came back as a list
    "artists"
    |> select([_], [:name, :id])
    |> Repo.all()
  end

  def inspect_sql do
    # Define a query that selects all the artist birth_dates. Then use
    # Ecto.Adapters.SQL.to_sql(:all, Repo, query) to inspect the raw sql.
    query = "artists"
    |> select([_], [:birth_date])

    Ecto.Adapters.SQL.to_sql(:all, Repo, query)
  end

  def find_artist_by_name(name) do
    # Define a query that finds an artist by the name passed to this function.
    # Then use Repo.all to fetch the record with that query.
    "artists"
    |> select([_], [:name, :id, :birth_date])
    |> where([a], a.name == ^name)
    |> Repo.all()
  end

  def search_tracks(title) do
    # Define a query that finds tracks with a title like the title passed in.
    # This function should leverage sql's like functionality.
    "tracks"
    |> select([_], [:title])
    |> where([t], like(t.title, ^title))
    |> Repo.all()
  end

  def search_albums_by_track(track_title) do
    # Define a query that fetches all the albums and includes their tracks
    # in a join. Then search the tracks by title like the query above.
    # :inner, [c], p in Post, on: c.post_id == p.id
    "albums"
    |> join(:inner, [a], t in "tracks", on: a.id == t.album_id)
    |> select([a, t], [t.title])
    |> where([a, t], like(t.title, ^track_title))
    |> Repo.all()
  end

  def find_and_update_track!(title) do
    # Find a track by title and use Repo.update_all to set the title to "Rolling in the Deep"
    "tracks"
    |> select([_], [:title])
    |> where([t], like(t.title, ^title))
    |> Repo.update_all(set: [title: "Rolling in the Deep"])
  end

  def find_and_delete_track!(title) do
    # Find a track by title and delete it using Repo.delete_all.
    "tracks"
    |> select([_], [:title])
    |> where([t], like(t.title, ^title))
    |> Repo.delete_all()
  end

  def order_artists_by_name do
    # Select all artists and use `order_by:` to order them by name desc.
    "artists"
    |> select([a], [a.name])
    |> order_by([desc: :name])
    |> Repo.all()
  end

  def group_album_duration do
    # Query tracks and select the album_id and use sum to calculate the duration, then
    # group by album_id.
    "tracks"
    |> group_by([t], t.album_id)
    |> select([t], [t.album_id, sum(t.duration)])
    |> Repo.all()
  end
end
