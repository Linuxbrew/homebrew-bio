class Roary < Formula
  # cite Page_2015: "https://doi.org/10.1093/bioinformatics/btv421"
  desc "High speed stand alone pan-genome pipeline"
  homepage "https://sanger-pathogens.github.io/Roary/"
  url "https://github.com/sanger-pathogens/Roary/archive/v3.13.0.tar.gz"
  sha256 "375f83c8750b0f4dea5b676471e73e94f3710bc3a327ec88b59f25eae1c3a1e8"
  revision 1

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-bio"
    cellar :any_skip_relocation
    sha256 "42756c86160f232c78b00aab596587d9726779f72ccd85e15d778371b9efb800" => :catalina
    sha256 "68842be0ec83d5d0292006df13ae08aa864a66548551d18ee1118f54d545b958" => :x86_64_linux
  end

  depends_on "cpanminus" => :build

  depends_on "bedtools"
  depends_on "blast"
  depends_on "brewsci/bio/bioperl"
  depends_on "brewsci/bio/cd-hit"
  depends_on "brewsci/bio/fasttree"
  depends_on "brewsci/bio/kraken"
  depends_on "brewsci/bio/mcl"
  depends_on "brewsci/bio/prank"
  depends_on "mafft"
  depends_on "parallel"
  depends_on "perl" # needs brewed bioperl

  uses_from_macos "libxml2"

  def install
    libexec.install Dir["bin/*"]
    pkgshare.install "contrib"

    # let CPAN install these
    rm_r buildpath/"lib"
    rm_r buildpath/"t"
    rm_r buildpath/"bin"
    bin.mkpath

    ENV.prepend "PERL5LIB", Formula["bioperl"].libexec/"lib/perl5"
    ENV.prepend_create_path "PERL5LIB", prefix/"perl5/lib/perl5"

    # --notest because https://github.com/sanger-pathogens/Roary/issues/386
    system "cpanm", "--notest", "--self-contained", "-l", prefix/"perl5", "Bio::Roary"

    Dir[libexec/"*"].each do |exe|
      name = File.basename exe
      (bin/name).write_env_script(exe, :PERL5LIB => ENV["PERL5LIB"])
    end
  end

  def caveats
    <<~EOS
      The included .R scripts need R and ggplot2 to be installed separately.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/roary -w 2>&1")
    assert_match version.to_s, shell_output("#{bin}/roary -a 2>&1")
    assert_match "core", shell_output("#{bin}/roary -h 2>&1")
  end
end
