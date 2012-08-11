require 'formula'

class Pixman < Formula
  homepage 'http://cairographics.org/'
  url 'http://cairographics.org/releases/pixman-0.26.2.tar.gz'
  sha256 'c9ab554b5160679d958bfa1753cb9e6edd1e53c4745c963a1394eea4f0b13ce2'

  depends_on 'pkg-config' => :build

  fails_with :llvm do
    build 2336
    cause <<-EOS.undent
      Building with llvm-gcc causes PDF rendering issues in Cairo.
      https://trac.macports.org/ticket/30370
      See Homebrew issues #6631, #7140, #7463, #7523.
      EOS
  end

  def options
    [["--universal", "Build a universal binary."]]
  end

  def install
    ENV.universal_binary if ARGV.build_universal?

    # Disable gtk as it is only used to build tests
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--enable-gtk=no"
    system "make install"
  end
end
