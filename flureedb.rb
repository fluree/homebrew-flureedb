class Flureedb < Formula
  desc "Graph database with a blockchain backbone"
  homepage "https://www.flur.ee"
  url "https://fluree-releases-public.s3.amazonaws.com/fluree-latest.zip", :tag => 'latest'
  sha256 "240a285b75a41f5f4bdefc285d666b77033ee2bcb95b6ce74cbf9a3f4b9d80e4"
  version "1.0.1"

  def install
    prefix.install Dir["./*"]
  end

end
