class Flureedb < Formula
  desc "Graph database with a blockchain backbone"
  homepage "https://www.flur.ee"
  url "https://s3.amazonaws.com/fluree-releases-public/flureeDB-latest.zip"
  sha256 "240a285b75a41f5f4bdefc285d666b77033ee2bcb95b6ce74cbf9a3f4b9d80e4"

  def install
    bin.install './flureeDB.jar'
    bin.install './CHANGELOG.md'
    bin.install './flureeDB_transactor.sh'
    bin.install './flureeDB.properties'
    bin.install './LICENSE'
    bin.install './VERSION'
  end

end