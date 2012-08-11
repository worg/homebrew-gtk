require 'formula'

class GtkEngines <Formula
  homepage 'http://www.gnome.org/'
  url 'http://ftp.gnome.org/pub/GNOME/sources/gtk-engines/2.20/gtk-engines-2.20.2.tar.bz2'
  sha256 '15b680abca6c773ecb85253521fa100dd3b8549befeecc7595b10209d62d66b5'

  depends_on 'gettext'
  depends_on 'worg/gtk/gtk+'
  depends_on 'worg/gtk/cairo'
  depends_on 'intltool'

  def options
    [["--universal", "Builds a universal binary"]]
  end

  def install
    ENV.universal_binary if ARGV.build_universal?
    # Cairo is keg-only, so this needs to be specified.
    cairo_pkgconfig = File.join(Formula.factory("cairo").prefix, 'lib', 'pkgconfig')
    gettext = Formula.factory('gettext')
    ENV['PKG_CONFIG_PATH'] = cairo_pkgconfig

    system "./configure", "--prefix=#{prefix}", "--enable-animation"
    system "make install"
  end
end
