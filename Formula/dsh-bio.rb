class DshBio < Formula
  desc "Tools for BED, FASTA, FASTQ, GFA1/2, GFF3, SAM, and VCF files"
  homepage "https://github.com/heuermh/dishevelled-bio"
  url "https://search.maven.org/remotecontent?filepath=org/dishevelled/dsh-bio-tools/1.3.1/dsh-bio-tools-1.3.1-bin.tar.gz"
  sha256 "aae6e3e283f71994acf0f17152e088a98e1f240ab1c1f56e7035a474600e5972"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-bio"
    cellar :any_skip_relocation
    sha256 "8f227cdab85ebad698b670fd74576e82b2f2e41557294c6ff6f3303adf4d1643" => :mojave
    sha256 "bc5c1fc03571f4ffbc57dd59d8951878041d0f9b7a00729886f35e027c8d9208" => :x86_64_linux
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
