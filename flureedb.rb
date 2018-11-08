class Flureedb < Formula
  desc "Graph database with a blockchain backbone"
  homepage "https://www.flur.ee"
  url "https://s3.amazonaws.com/fluree-releases-public/flureeDB-0.9.1.zip", :tag => 'v0.9.1'
  sha256 "240a285b75a41f5f4bdefc285d666b77033ee2bcb95b6ce74cbf9a3f4b9d80e4"
  version "1.0.0"

  def install
    prefix.install Dir["./*"]
  end

end
