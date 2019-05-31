class Flureedb < Formula
  desc "Graph database with a blockchain backbone"
  homepage "https://www.flur.ee"
  url "https://fluree-releases-public.s3.amazonaws.com/fluree-0.9.5-PREVIEW3.zip", :tag => 'v0.9.5-3'
  sha256 "2837836b651a76105c428e8b450d0d4c86bce2fcda434435b663bbbdf149c9c8"
  version "1.0.1"

  def install
    prefix.install Dir["./*"]
  end

end
