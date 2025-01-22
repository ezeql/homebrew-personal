class Oabtray < Formula
  desc "Bitcoin price tracker for macOS menu bar with ALABA_FACTOR"
  homepage "https://github.com/ezeql/oabtray"
  url "https://github.com/ezeql/oabtray/archive/refs/tags/v0.1.9.tar.gz"
  sha256 "8f80480352ed7f6b20832c7189282b7ae30cfa05c1c83c5f1c046841e123f111"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build", 
           "-ldflags=-s -w " + 
           "-X main.VERSION=v0.1.9 " +
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