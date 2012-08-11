require 'formula'

class Libpng < Formula
  homepage 'http://www.libpng.org/pub/png/libpng.html'
  url 'http://downloads.sf.net/project/libpng/libpng15/1.5.12/libpng-1.5.12.tar.gz'
  sha1 'c329f3a9b720d7ae14e8205fa6e332236573704b'

  keg_only :provided_by_osx if MacOS::X11.installed?

  def options
  [
    ['--universal', 'Build universal binaries.'],
    ['--test', 'Build a debug build and run tests. NOTE: Tests may hang on "unix-streams".']
  ]
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
