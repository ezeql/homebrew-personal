class Oabtray < Formula
  desc "Bitcoin price tracker for macOS menu bar with ALABA_FACTOR"
  homepage "https://github.com/ezeql/oabtray"
  url "https://github.com/ezeql/oabtray/archive/refs/tags/v0.1.8.tar.gz"
  sha256 "e8eae641af41d1dd4a7c39c78281b0712fa69656482cc3f735f6065eb162e277"
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