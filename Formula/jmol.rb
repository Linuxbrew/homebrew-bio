class Jmol < Formula
  desc "Open-source Java viewer for chemical structures in 3D"
  homepage "https://jmol.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/jmol/Jmol/Version%2014.31/Jmol%2014.31.31/Jmol-14.31.31-binary.zip"
  sha256 "985beabb414b3780985c12ade5c22b4a3d6f79b15ed7460dc58e70099f253616"
  license "LGPL-2.1-or-later"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-bio"
    sha256 cellar: :any_skip_relocation, catalina:     "fd7d18ef8ceeb0cb2d2a7fe6abeef12c231631cb203131e0ddabdeb633d155b1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "5061f8b6bc9fac4da7709ecb4efab366426ba9da9ee5f2412c297323256676ad"
  end

  head do
    url "https://svn.code.sf.net/p/jmol/code/trunk/Jmol"
    depends_on "ant" => :build
  end

  depends_on "openjdk"

  def install
    if build.head?
      system "ant"
      libexec.install Dir["build/*.jar"]
    else
      libexec.install Dir["*.jar"]
    end
    chmod 0755, "jmol.sh"
    bin.install "jmol.sh" => "jmol"
    env = {
      JMOL_HOME: libexec,
      JAVA_HOME: Formula["openjdk"].opt_prefix,
      PATH:      "#{Formula["openjdk"].opt_bin}:$PATH",
    }
    bin.env_script_all_files libexec/"bin", env
  end

  test do
    on_macos do
      assert_match version.to_s, shell_output("#{bin}/jmol -n")
    end

    on_linux do
      # unfortunately, the application can not be run headless
      assert_match "java.awt.HeadlessException", shell_output("#{bin}/jmol -n 2>&1", 1) if ENV["CI"]
    end
  end
end
