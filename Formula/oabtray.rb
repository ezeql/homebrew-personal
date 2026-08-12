class Oabtray < Formula
  desc "Bitcoin price tracker for macOS menu bar with ALABA_FACTOR"
  homepage "https://github.com/ezeql/oabtray"
  url "https://github.com/ezeql/oabtray/archive/refs/tags/v0.1.11.tar.gz"
  sha256 "ee12f005cc853b43d2fb978ca810ebafa223269c28712607f83f1eedd3c8e577"
  license "MIT"

  depends_on "go" => :build

  def install
    mkdir_p bin
    system "go", "build",
           "-ldflags=-s -w " +
           "-X main.VERSION=v0.1.11",
           "-o", bin/"oabtray"
  end

  service do
    run opt_bin/"oabtray"
    keep_alive true
    log_path var/"log/oabtray.log"
    error_log_path var/"log/oabtray.log"
  end

  test do
    assert_match "OAB Tray", shell_output("#{bin}/oabtray -version")
  end
end