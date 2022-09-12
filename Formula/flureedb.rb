# typed: false
# frozen_string_literal: true

# Homebrew formula for Fluree (yes this comment is dumb; thank rubocop)
class Flureedb < Formula
  desc "Graph database with a blockchain backbone"
  homepage "https://www.flur.ee"
  url "https://fluree-releases-public.s3.amazonaws.com/fluree-1.0.4.zip"
  sha256 "94542ad24f80899008236e9300c81d9416c6811fdebee3affc8061db8ca5a1f9"
  license "AGPL-3.0-only"

  head do
    url "https://github.com/fluree/ledger.git", branch: "main"
    depends_on "clojure" => :build
    depends_on "npm" => :build
  end

  depends_on "openjdk"

  def edit_config(file)
    inreplace file do |p|
      p.gsub!(/(?:#\s*)?fdb-group-config-path=.*/, "fdb-group-config-path=#{etc}")
      p.gsub!(/(?:#\s*)?fdb-storage-file-root=.*/, "fdb-storage-file-root=#{var}/lib/fluree")
      p.gsub!(/(?:#\s*)?fdb-group-log-directory=.*/, "fdb-group-log-directory=#{var}/lib/fluree/group")
    end
  end

  def install_head
    require "language/node"
    edit_config "resources/fluree_sample.properties"
    # have to do npm install first like this cuz homebrew
    # see: https://docs.brew.sh/Node-for-Formula-Authors
    system "npm", "install", *Language::Node.local_npm_install_args
    system "make", "install", "DESTDIR=#{prefix}"
  end

  def install_release
    bin.install "fluree_start.sh" => "fluree"
    (share/"java").install "fluree-ledger.standalone.jar"

    edit_config "fluree_sample.properties"
    etc.install "fluree_sample.properties" => "fluree.properties"

    etc.install "logback.xml" => "fluree-logback.xml"
  end

  def install
    (var/"lib").mkdir unless (var/"lib").exist?
    (var/"lib/fluree").mkdir unless (var/"lib/fluree").exist?
    if build.head?
      install_head
    else
      install_release
    end
  end

  def caveats
    "FlureeDB's web admin UI defaults to port 8090."
  end

  plist_options manual: "#{HOMEBREW_PREFIX}/bin/fluree"

  def plist
    <<~EOS
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
        <dict>
          <key>Label</key>
          <string>#{plist_name}</string>
          <key>ProgramArguments</key>
          <array>
            <string>#{opt_bin}/fluree</string>
          </array>
          <key>RunAtLoad</key>
          <true />
          <key>EnvironmentVariables</key>
          <dict>
            <key>JAVA_HOME</key>
            <string>#{Formula["openjdk"].opt_prefix}</string>
          </dict>
          <key>StandardErrorPath</key>
          <string>#{var}/log/fluree.error.log</string>
          <key>StandardOutPath</key>
          <string>#{var}/log/fluree.log</string>
        </dict>
      </plist>
    EOS
  end

  test do
    assert_equal "Fluree successfully installed and ready to run",
                 shell_output("#{bin}/fluree test")

    system "brew", "services", "start", "flureedb"
    sleep 3

    assert_match(/^{"ready":true/, shell_output("curl http://localhost:8090/fdb/health"))

    system "brew", "services", "stop", "flureedb"
  end
end
