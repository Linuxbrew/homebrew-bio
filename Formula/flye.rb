class Flye < Formula
  include Language::Python::Virtualenv

  # cite Kolmogorov_2018: "https://doi.org/10.1101/247148"
  desc "Fast and accurate de novo assembler for single molecule sequencing reads"
  homepage "https://github.com/fenderglass/Flye"
  url "https://github.com/fenderglass/Flye/archive/2.8.3.tar.gz"
  sha256 "070f9fbee28eef8e8f87aaecc048053f50a8102a3715e71b16c9c46819a4e07c"
  license "BSD-3-Clause"
  head "https://github.com/fenderglass/Flye.git", branch: "flye"

  bottle do
    root_url "https://archive.org/download/brewsci/bottles-bio"
    sha256 cellar: :any_skip_relocation, catalina:     "0c461022fa8f1b41ac6ea79bb320a913c09da9cb89930c912e0be0edddf253c7"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "1f0c23f01533968deab9bc997bd116cea9a11b1941f325981370d9899815cc83"
  end

  depends_on "python@3.9"

  def install
    # Uses internal parallelization for builds
    ENV.deparallelize
    virtualenv_install_with_resources
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/flye --version")
  end
end
