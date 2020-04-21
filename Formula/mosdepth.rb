class Mosdepth < Formula
  desc "Fast BAM/CRAM depth calculator"
  homepage "https://github.com/brentp/mosdepth"
  url "https://github.com/brentp/mosdepth/releases/download/v0.2.9/mosdepth"
  sha256 "a73283fb1a7465601a4d2d738f6f832f2fd84bf9181e0d4d2b91453da385177c"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-bio"
    cellar :any_skip_relocation
  end

  depends_on :linux

  unless OS.mac?
    depends_on "patchelf" => :build
    depends_on "htslib"
    depends_on "zlib"
  end

  def install
    bin.install "mosdepth"
    unless OS.mac?
      system "patchelf",
        "--set-interpreter", HOMEBREW_PREFIX/"lib/ld.so",
        "--set-rpath", HOMEBREW_PREFIX/"lib",
        bin/"mosdepth"
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/mosdepth --version 2>&1")
    assert_match "BAM-or-CRAM", shell_output("#{bin}/mosdepth -h 2>&1")
  end
end
