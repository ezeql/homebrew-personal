class HeosUi < Formula
  desc "Web UI and CLI for Denon/HEOS speakers"
  homepage "https://github.com/ezeql/heos-ui"
  url "https://github.com/ezeql/heos-ui/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "749d534782fedaac7f7ccff1261d91043a625384c66271a1d5f6befb2048aa47"
  head "https://github.com/ezeql/heos-ui.git", branch: "main"

  depends_on "go" => :build
  # Most SoundCloud tracks are HLS only now; ffmpeg converts them for the speaker.
  depends_on "ffmpeg"

  def install
    { "ui" => "heos-ui", "now" => "heos-now", "tracklist" => "heos-tracklist" }.each do |cmd, name|
      system "go", "build", *std_go_args(ldflags: "-s -w", output: bin/name), "./cmd/#{cmd}"
    end
  end

  def caveats
    <<~EOS
      heos-ui serves the web UI at http://localhost:8080 (-port changes it).
      heos-now and heos-tracklist show which track of a DJ set is playing.

      macOS has to let it reach the speakers, and let them reach it:
        - System Settings > Privacy & Security > Local Network: allow the
          terminal you run it from.
        - With the firewall on, allow incoming connections for heos-ui: the
          speaker fetches converted SoundCloud tracks from it.

      Links from sites other than SoundCloud need yt-dlp:
        brew install yt-dlp
    EOS
  end

  test do
    assert_match "-port", shell_output("#{bin}/heos-ui -h 2>&1")
    assert_match "-host", shell_output("#{bin}/heos-now -h 2>&1")
    assert_match "-at", shell_output("#{bin}/heos-tracklist -h 2>&1")
  end
end
