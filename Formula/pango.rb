require 'formula'

class Pango < Formula
  homepage 'http://www.pango.org/'
  url 'http://ftp.gnome.org/pub/GNOME/sources/pango/1.30/pango-1.30.1.tar.xz'
  sha256 '3a8c061e143c272ddcd5467b3567e970cfbb64d1d1600a8f8e62435556220cbe'

  devel do
    url 'http://ftp.gnome.org/pub/gnome/sources/pango/1.29/pango-1.29.4.tar.bz2'
    sha256 'f15deecaecf1e9dcb7db0e4947d12b5bcff112586434f8d30a5afd750747ff2b'
  end

  depends_on 'pkg-config' => :build
  depends_on 'glib'
  
  def options
    [["--universal", "Builds a universal binary"]]
  end
  
  if MacOS.leopard?
    depends_on 'fontconfig' # Leopard's fontconfig is too old.
    depends_on 'worg/gtk/cairo' # Leopard doesn't come with Cairo.
  elsif MacOS.lion?
    # The Cairo library shipped with Lion contains a flaw that causes Graphviz
    # to segfault. See the following ticket for information:
    #
    #   https://trac.macports.org/ticket/30370
    depends_on 'worg/gtk/cairo'
  end

  fails_with :llvm do
    build 2326
    cause "Undefined symbols when linking"
  end

  def patches
    p = {}
    unless ARGV.build_devel?
      # Some things that depend on pango and glib 2.30.x have issues with the deprecated
      # G_CONST_RETURN. Shouldn't be an issue with 1.29.x.
      p[:p0] = "https://trac.macports.org/export/89719/trunk/dports/x11/pango/files/patch-G_CONST_RETURN.diff"
    end

    if ARGV.build_devel? and MacOS.lion?
      # Fixes font size rendering in lion. See the following post for details
      # http://web.me.com/aschweiz/Website/Blog/Entries/2011/10/6_CoreText_vs._FontConfig.html
      p[:p1] = "http://web.me.com/aschweiz/Website/Blog/Entries/2011/10/6_CoreText_vs._FontConfig_files/pango-1.29.3-coretext.patch"
    end
    return p
  end

  def install
    ENV.universal_binary if ARGV.build_universal?
    system "./configure", "--disable-dependency-tracking",
                          "--disable-debug",
                          "--prefix=#{prefix}",
                          "--enable-man",
                          "--without-x",
                          "--with-html-dir=#{share}/doc",
                          "--disable-introspection"
    system "make"
    system "make install"
  end

  def test
    mktemp do
      system "#{bin}/pango-view -t 'test-image' --waterfall --rotate=10 --annotate=1 --header -q -o output.png"
      system "/usr/bin/qlmanage -p output.png"
    end
  end
end
