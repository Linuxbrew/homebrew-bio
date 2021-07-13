class Bbtools < Formula
  desc "Suite of Brian Bushnell's tools for manipulating reads"
  homepage "https://jgi.doe.gov/data-and-tools/bbtools/"
  url "https://downloads.sourceforge.net/bbmap/BBMap_38.89.tar.gz"
  sha256 "3fe4265894d1233664713f784665dea64cc444bf5bcf48f9ac95e76153abf7f3"

  bottle do
    root_url "https://ghcr.io/v2/brewsci/bio"
    sha256 cellar: :any, catalina:     "1a682ddc8c91764867417564a23d07ee8d166e1e754aa1b17bbb82326723f219"
    sha256 cellar: :any, x86_64_linux: "1e0f94031afe0957c5db853a8fe7914facf0c93bbe0127d55f4ab8bcf906f548"
  end

  depends_on "openjdk"

  def install
    if OS.mac?
      system "make", "--directory=jni", "-f", "makefile.osx"
    elsif OS.linux?
      system "make", "--directory=jni", "-f", "makefile.linux"
    end
    prefix.install %w[current jni resources]
    # shell scripts look for ./{current,jni,resources} files, so keep shell scripts
    # in #{prefix} but place symlinks in the ../bin dir for brew to export #{bin}
    bin.install Dir["*.sh"]
    bin.env_script_all_files prefix, JAVA_HOME: "${JAVA_HOME:-#{Formula["openjdk"].opt_prefix}}"
    doc.install %w[license.txt README.md docs/changelog.txt docs/Legal.txt docs/readme.txt docs/ToolDescriptions.txt]
  end

  test do
    res = prefix/"resources"
    args = %W[in=#{res}/sample1.fq.gz
              in2=#{res}/sample2.fq.gz
              out=R1.fastq.gz
              out2=R2.fastq.gz
              ref=#{res}/phix174_ill.ref.fa.gz
              k=31
              hdist=1]
    system "#{bin}/bbduk.sh", *args
    assert_match "bbushnell@lbl.gov", shell_output("#{bin}/bbmap.sh")
    assert_match "maqb", shell_output("#{bin}/bbmap.sh --help 2>&1")
    assert_match "minkmerhits", shell_output("#{bin}/bbduk.sh --help 2>&1")
  end
end
