defmodule RepoExercisesTest do
  use MusicDB.DBCase
  import Ecto.Query
  alias MusicDB.Exercises.RepoExercises

  test "insert a single record with insert_all" do
    RepoExercises.insert_a_single_record()
    assert find_artist("Jimi Hendrix") == [%{name: "Jimi Hendrix"}]
  end

  test "insert multiple records with insert_all" do
    RepoExercises.insert_multiple_records()
    assert find_artist("Charlie Parker") == [%{name: "Charlie Parker"}]
    assert find_artist("Dizzie Gillespie") == [%{name: "Dizzie Gillespie"}]
  end

  test "delete records with delete_all" do
    RepoExercises.insert_multiple_records()
    RepoExercises.delete_all_artists()
    assert Repo.all(from("artists", select: [:id])) == []
  end

  test "add a custom function to MusicDB.Repo that counts records in a table" do
    RepoExercises.insert_multiple_records()
    assert Repo.count("artists") == 2
  end

  test "insert a single record and customize the return the id" do
    result = RepoExercises.insert_a_single_record_and_return_the_id()
    assert {1, [%{id: _id}]} = result
  end

  def find_artist(name) do
    Repo.all(from("artists", where: [name: ^name], select: [:name]))
  end
end
