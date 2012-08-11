require 'formula'

class Libpng < Formula
  homepage 'http://www.libpng.org/pub/png/libpng.html'
  url 'ftp://ftp.simplesystems.org/pub/libpng/png/src/libpng-1.5.10.tar.xz'
  md5 '9c2ac3c3a31de2ab867875718f8de18e'

  keg_only :provided_by_osx

  def options
    [["--universal", "Builds a universal binary"]]
  end

  def install
    ENV.universal_binary if ARGV.build_universal?
    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make install"
    system "make test"

    # Move included test programs into libexec for later use
    libexec.install 'pngtest.png', '.libs/pngtest'
  end

  def test
    mktemp do
      system "#{libexec}/pngtest", "#{libexec}/pngtest.png"
      system "/usr/bin/qlmanage", "-p", "pngout.png"
    end
  end
end
