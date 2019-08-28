defmodule MusicDB.Exercises.AssociationExercises do
  import Ecto.Query
  alias MusicDB.{Repo, Album, Release}

  def insert_album_and_release do
    # insert an album with the title "Giant Steps" along with an associated release with the
    # title "Giant Steps (remastered)"
    album = %Album{title: "Giant Steps"}
    |> Repo.insert!()

    %Release{album: album, title: "Giant Steps (remastered)"}
    |> Repo.insert!()
    :ok
  end

  def fetch_album_with_releases do
    # load the album with the title "Giant Steps" and make sure the releases are preloaded
    Album
    |> preload(:releases)
    |> select([a], a)
    |> where([a], a.title == "Giant Steps")
    |> Repo.one!()
  end

  def delete_album_and_release(album) do
    # delete the given album - make sure the association is setup so that the associated release
    # is deleted as well
    album
    |> Repo.delete!()
  end
end
