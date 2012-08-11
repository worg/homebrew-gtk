require 'formula'

class Libcroco <Formula
  url 'http://ftp.gnome.org/pub/GNOME/sources/libcroco/0.6/libcroco-0.6.5.tar.xz'
  sha256 '2c6959c3644e889264a61c35ddf17401c86943681d4fe3c1682ecd9acabda7e3'
  homepage 'http://www.freespiders.org/projects/libcroco/'

  depends_on 'pkg-config'
  depends_on 'glib'
  depends_on 'intltool'

  def install
    system "./configure", "--prefix=#{prefix}", "--disable-debug", "--disable-dependency-tracking"
    system "make install"
  end
end
