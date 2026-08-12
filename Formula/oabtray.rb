class Oabtray < Formula
  desc "Bitcoin price tracker for macOS menu bar with ALABA_FACTOR"
  homepage "https://github.com/ezeql/oabtray"
  url "https://github.com/ezeql/oabtray/archive/refs/tags/v0.1.10.tar.gz"
  sha256 "1ac6a6f8989039a0f1650afbffbde27123b98eaec23572924ef5b289557c80c2"
  license "MIT"

  depends_on "go" => :build

  def install
    mkdir_p bin
    system "go", "build",
           "-ldflags=-s -w " +
           "-X main.VERSION=v0.1.10",
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