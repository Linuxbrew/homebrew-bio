class DshBio < Formula
  desc "Tools for BED, FASTA, FASTQ, GFA1/2, GFF3, SAM, and VCF files"
  homepage "https://github.com/heuermh/dishevelled-bio"
  url "https://search.maven.org/remotecontent?filepath=org/dishevelled/dsh-bio-tools/1.3.4/dsh-bio-tools-1.3.4-bin.tar.gz"
  sha256 "afe12e1efb15a7b391628db8622817da3a39ac60291905707c7d97b3e707962d"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-bio"
    cellar :any_skip_relocation
    sha256 "d9d5d0de4ff0de537b91592d62dc67dbe8168f86d2e19f6c6990f2a4d7e16849" => :catalina
    sha256 "5a6f21293a68a0619709f3784c1bb37711fc284d912f010f001471499d18086b" => :x86_64_linux
  end

  depends_on :java => "1.8+"

  def install
    rm Dir["bin/*.bat"] # Remove all windows files
    libexec.install Dir["*"]
    bin.write_exec_script Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match "usage", shell_output("#{bin}/dsh-bio --help")
  end
end
