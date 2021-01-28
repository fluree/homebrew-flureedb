# typed: false
# frozen_string_literal: true

# Homebrew formula for Fluree (yes this comment is dumb; thank rubocop)
class Flureedb < Formula
  desc "Graph database with a blockchain backbone"
  homepage "https://www.flur.ee"
  url "https://fluree-releases-public.s3.amazonaws.com/fluree-1.0.0-beta3.zip"
  sha256 "d7fdf3b6b70d38c5c65d7206ed2d04efd8187878ba80da18a511404f8df6f2c2"
  license "AGPL-3.0-only"

  head do
    url "https://github.com/fluree/ledger.git", branch: "feature/homebrew-1.0"
    depends_on "clojure" => :build
  end

  bottle :unneeded

  depends_on "openjdk"

  def install_head
    ohai "Prefix is #{prefix}"
    system "make", "install", "DESTDIR=#{prefix}"
  end

  def install_release
    bin.install "fluree_start.sh" => "fluree"
    (share/"java").install "fluree-ledger.standalone.jar"
    etc.install "fluree_sample.properties" => "fluree.properties"
    etc.install "logback.xml" => "fluree-logback.xml"
  end

  def install
    if build.head?
      install_head
    else
      install_release
    end
  end

  test do
    assert_equal "Fluree successfully installed and ready to run",
                 shell_output("#{bin}/fluree test")
  end
end
