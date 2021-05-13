class Cannoli < Formula
  desc "Big Data Genomics ADAM Pipe API wrappers for bioinformatics tools"
  homepage "https://github.com/bigdatagenomics/cannoli"
  url "https://search.maven.org/remotecontent?filepath=org/bdgenomics/cannoli/cannoli-distribution-spark3_2.12/0.13.0/cannoli-distribution-spark3_2.12-0.13.0-bin.tar.gz"
  sha256 "9e55ff81d56ed4307d35b743405f98a52b3081696c3c2ed56004340611204aab"

  livecheck do
    url :homepage
    strategy :github_latest
    regex(%r{href=.*?/tag/cannoli-parent-spark\d+[_-]\d+(?:\.\d+)+[_-]v?(\d+(?:\.\d+)+)["' >]}i)
  end

  bottle do
    root_url "https://ghcr.io/v2/brewsci/bio"
    sha256 cellar: :any_skip_relocation, catalina:     "50feecf46705edd872d336c64f259f4b6b5fda41bcc162281fbb1f9b11aa9248"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "edca7dd1a8d501e76fbdc09ecb844122ca6e91490e899c8344539b6a8a174121"
  end

  head do
    url "https://github.com/bigdatagenomics/cannoli.git", shallow: false
    depends_on "maven" => :build
  end

  depends_on "apache-spark"

  def install
    system "mvn", "clean", "install", "-DskipTests=true" if build.head?
    libexec.install Dir["*"]
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match "Usage", shell_output("#{bin}/cannoli-submit --help")
  end
end
