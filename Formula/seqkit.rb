class Seqkit < Formula
  # cite Shen_2016: "https://doi.org/10.1371/journal.pone.0163962"
  desc "Ultrafast FASTA/Q file manipulation"
  homepage "https://bioinf.shenwei.me/seqkit/"
  # We use binaries to avoid compiling Go code
  if OS.mac?
    url "https://github.com/shenwei356/seqkit/releases/download/v0.15.0/seqkit_darwin_amd64.tar.gz"
    sha256 "5428cf6e2d04efd0adc0fa045a3f90fd37c34235630be2819aef0de25901f12a"
  else
    url "https://github.com/shenwei356/seqkit/releases/download/v0.15.0/seqkit_linux_amd64.tar.gz"
    sha256 "bf305e7d5b4fbe14a6e87ebf6aa454117dd3cf030cb9473d01161c0a1987a182"
  end
  version "0.15.0"
  license "MIT"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-bio"
    cellar :any_skip_relocation
    sha256 "48b2bcd5bb7e30f810aa517eef0d357391b968eb3120baff42a02f6c3432a18c" => :catalina
    sha256 "2b311ca6b3a6f5febf6baeafcefd6524d05de38c3bf0eaa26b32472c8f51ad92" => :x86_64_linux
  end

  def install
    bin.install "seqkit"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/seqkit version")
  end
end
