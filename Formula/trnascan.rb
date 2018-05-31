class Trnascan < Formula
  # cite Lowe_1997: "https://doi.org/10.1093/nar/25.5.0955"
  desc "Detect tRNA in genome sequence"
  homepage "http://eddylab.org/software.html"
  url "http://eddylab.org/software/tRNAscan-SE/tRNAscan-SE-1.3.1.tar.gz"
  version "1.3.1"
  sha256 "862924d869453d1c111ba02f47d4cd86c7d6896ff5ec9e975f1858682282f316"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-bio"
    sha256 "a54b3d2b603962584f862f25c1a385bd38653d1b691df8ece20319e6f0848e27" => :sierra_or_later
    sha256 "d81fc3713ae3db57312729afa507a2858a9c406107fd130b0a5ada21c7db01b3" => :x86_64_linux
  end

  def install
    system "make", "all", "CFLAGS=-D_POSIX_C_SOURCE=1", "BINDIR=#{bin}", "LIBDIR=#{libexec}"
    bin.install %w[coves-SE covels-SE eufindtRNA trnascan-1.4 tRNAscan-SE]
    libexec.install Dir["gcode.*", "*.cm", "*signal"]
    man1.install "tRNAscan-SE.man" => "tRNAscan-SE.1"
    prefix.install "Demo"
    (prefix/"Demo").install "testrun.ref"
  end

  test do
    system "#{bin}/tRNAscan-SE", "-d", "-y", "-o", "test.out", "#{prefix}/Demo/F22B7.fa"
    assert_predicate testpath/"test.out", :exist?
    assert_equal File.read("test.out"), File.read(prefix/"Demo/testrun.ref")
  end
end
