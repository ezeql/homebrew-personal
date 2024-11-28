class Oabtray < Formula
  desc "Bitcoin price tracker for macOS menu bar with ALABA_FACTOR"
  homepage "https://github.com/ezeql/oabtray"
  url "https://github.com/ezeql/oabtray/archive/refs/tags/v0.1.6.tar.gz"
  sha256 "744059baa92040f34d17b4b5de18d5909c43fefb217a619be325097dc4db5a21"
  license "MIT"

  depends_on "go" => :build

  def install
    # Create bin directory first
    bin.mkpath
    
    system "go", "build", 
           "-ldflags=-s -w " + 
           "-X main.VERSION=#{version}", 
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