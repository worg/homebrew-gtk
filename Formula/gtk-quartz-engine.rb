require 'formula'

class GtkQuartzEngine < Formula
  homepage 'http://sourceforge.net/apps/trac/gtk-osx/wiki/GtkQuartzEngine'
  url 'http://sourceforge.net/projects/gtk-osx/files/GTK%20Quartz%20Engine/gtk-quartz-engine-0.2.tar.gz'
  #md5 'fa729b96ed11cde912e002c553ba7227'

  head 'git://github.com/worg/gtk-quartz-engine'

  depends_on 'gettext'
  depends_on 'worg/gtk/gtk+'
  depends_on 'worg/gtk/cairo'
  depends_on 'intltool'
  depends_on 'libtool'

  def options
    [["--universal", "Builds a universal binary"]]
  end

  def install
    ENV.universal_binary if ARGV.build_universal?
    system "autoreconf -i"
    system "./autogen.sh", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    # system "cmake . #{std_cmake_parameters}"
    system "make install LIBTOOL=glibtool" # if this fails, try separate make/make install steps
  end
end
