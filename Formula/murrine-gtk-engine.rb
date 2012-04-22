require 'formula'

class MurrineGtkEngine < Formula
  homepage 'http://www.cimitan.com/murrine/'
  url 'http://ftp.acc.umu.se/pub/GNOME/sources/murrine/0.98/murrine-0.98.2.tar.xz'
  md5 'bf01e0097b5f1e164dbcf807f4b9745e'

  depends_on 'gettext'
  depends_on 'xz' => :build
  depends_on 'worg/gtk/gtk+'
  depends_on 'worg/gtk/cairo'
  depends_on 'intltool'

  def options
    [["--universal", "Builds a universal binary"]]
  end

  def install
    ENV.universal_binary if ARGV.build_universal?

    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--enable-animation"
    # system "cmake . #{std_cmake_parameters}"
    system "make install" # if this fails, try separate make/make install steps
  end
end
