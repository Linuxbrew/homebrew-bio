class Mrbayes < Formula
  # cite Ronquist_2003: "https://doi.org/10.1093/bioinformatics/btg180"
  desc "Bayesian inference of phylogenies and evolutionary models"
  homepage "https://nbisweden.github.io/MrBayes/"
  url "https://github.com/NBISweden/MrBayes/archive/v3.2.7a.tar.gz"
  sha256 "efc4ee9f1c8b0ba8ebcdd904541f971b4d41b1bd0198c758830e5d10a1b67c8d"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-bio"
    cellar :any_skip_relocation
    sha256 "a74e4e1ea82efca6bfca5efe791940bffe167467a121a417b770823bebe66039" => :sierra
    sha256 "de35643f5dc2c6f2234aed0d121b5446688fda285d0ecdd450a0258afc728717" => :x86_64_linux
  end

  depends_on "beagle" => :recommended
  depends_on "open-mpi" => :recommended
  depends_on "readline" => :recommended

  def install
    args = ["--prefix=#{prefix}"]
    args << "--with-beagle=" + (build.with?("beagle") ? Formula["beagle"].opt_prefix : "no")
    args << "--with-mpi="  + (build.with?("open-mpi") ? "yes" : "no")
    args << "--with-readline=" + (build.with?("readline") ? "yes" : "no")

    cd "src" do
      system "./configure", *args
      system "make"
      bin.install "mb"
    end

    pkgshare.install ["documentation", "examples"]
  end

  test do
    cp pkgshare/"examples/finch.nex", testpath
    cmd = "mcmc ngen = 50000; sump; sumt;"
    cmd = "set usebeagle=yes beagledevice=cpu;" + cmd if build.with? "beagle"
    inreplace "finch.nex", "end;", cmd + "\n\nend;"
    system bin/"mb", "finch.nex"
  end
end
