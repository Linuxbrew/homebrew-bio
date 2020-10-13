class SeqanAT3 < Formula
  # cite D_ring_2008: "https://doi.org/10.1186/1471-2105-9-11"
  # cite Reinert_2017: "https://doi.org/10.1016/j.jbiotec.2017.07.017"
  desc "Modern C++ library for sequence analysis"
  homepage "https://www.seqan.de"
  url "https://github.com/seqan/seqan3/releases/download/3.0.2/seqan3-3.0.2-Source.tar.xz"
  sha256 "bab1a9cd0c01fd486842e0fa7a5b41c1bf6d2c43fdadf4c543956923deb62ee9"
  head "https://github.com/seqan/seqan3.git"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-bio"
    cellar :any_skip_relocation
    sha256 "a221a1a4c196e733656015d81a21bbfbc87ecb5c86f9710d66ff7ff99de69323" => :catalina
    sha256 "b576cf25561c3d8ad3f6cb38b0231f7fee572899b5fe6c8475cf96d73ffbbd5b" => :x86_64_linux
  end

  depends_on "cmake" => :build
  depends_on "xz" => :build
  depends_on "gcc@9"

  # requires c++17 and concepts
  fails_with :clang do
    cause "seqan3 requires concepts and c++17 support"
  end

  fails_with gcc: "4.9" # requires C++17
  fails_with gcc: "5" # requires C++17
  fails_with gcc: "6" # requires C++17

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make", "install"
    end
  end

  test do
    assert_match "SEQAN3_VERSION_MAJOR", File.read(include/"seqan3/version.hpp")
  end
end
