require 'formula'

class Pycairo <Formula
  url 'http://cairographics.org/releases/py2cairo-1.10.0.tar.bz2'
  homepage 'http://cairographics.org/pycairo/'
  md5 '20337132c4ab06c1146ad384d55372c5'

  depends_on 'cairo'

  def install
    # Cairo is keg-only, so this needs to be specified.
    cairo_pkgconfig = File.join(Formula.factory("cairo").prefix, 'lib', 'pkgconfig')
    ENV['PKG_CONFIG_PATH'] = cairo_pkgconfig

    system "./configure", "--prefix=#{prefix}"
    system "make install"
  end
end
