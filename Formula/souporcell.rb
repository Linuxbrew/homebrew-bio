class Souporcell < Formula
  # cite Heaton_2019: "https://www.biorxiv.org/content/10.1101/699637v1"
  desc "Clustering scRNAseq by genotypes"
  homepage "https://github.com/wheaton5/souporcell"
  url "https://github.com/wheaton5/souporcell/archive/2.0.tar.gz"
  sha256 "308b0fc4edc410cf13a9d8e8572e80fd6ceadeb981703383f31b2fcaa138bf1c"

  depends_on "rust" => :build

  def install
    ENV["CARGO_INCREMENTAL"] = "0"
    cd "souporcell" do
      system "cargo", "install", "--root=#{prefix}", "--path=."
    end
    cd "troublet" do
      system "cargo", "install", "--root=#{prefix}", "--path=."
    end
  end

  test do
    assert_match "USAGE", shell_output("#{bin}/souporcell --help")
    assert_match "USAGE", shell_output("#{bin}/troublet --help")
  end
end
