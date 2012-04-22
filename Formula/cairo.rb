require 'formula'

class Cairo < Formula
  homepage 'http://cairographics.org/'
  url 'http://www.cairographics.org/releases/cairo-1.10.2.tar.gz'
  sha1 'ccce5ae03f99c505db97c286a0c9a90a926d3c6e'

  depends_on 'pkg-config' => :build
  depends_on 'pixman'

  keg_only :provided_by_osx,
            "The Cairo provided by Leopard is too old for newer software to link against."

  fails_with :llvm do
    build 2336
    cause "Throws an 'lto could not merge' error during build."
  end

  #http://git.gnome.org/browse/gtk-osx/plain/patches/0001-quartz-Fix-the-32-bits-build-on-MacOSX-10.7.patch

  def options
    [["--universal", "Builds a universal binary"]]
  end

  def install
    ENV.universal_binary if ARGV.build_universal?
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--enable-quartz=yes",
                          "--enable-quartz-font=yes",
                          "--enable-quartz-image",
                          "--disable-xlib",
                          "--disable-xlib-xrender",
                          "--without-x",
                          "--disable-xcb"
    system "make install"
  end
end
