class Oabtray < Formula
  desc "Bitcoin price tracker for macOS menu bar with ALABA_FACTOR"
  homepage "https://github.com/ezeql/oabtray"
  url "https://github.com/ezeql/oabtray/archive/refs/tags/v0.1.7.tar.gz"
  sha256 "a02a1a9e6ccdff13aea153c96742d653b3f2f791a4f08b5e73cd01f67ea78c0a"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build", 
           "-ldflags=-s -w " + 
           "-X main.VERSION=#{version} " +
           "-o", bin/"oabtray"
  end

  service do
    run opt_bin/"oabtray"
    keep_alive true
    log_path var/"log/oabtray.log"
    error_log_path var/"log/oabtray.log"
  end

  test do
    assert_match "OAB", shell_output("#{bin}/oabtray -h", 1)
  end
end