require 'formula'

class Glibmm <Formula
  url 'http://ftp.gnome.org/pub/GNOME/sources/glibmm/2.22/glibmm-2.22.2.tar.bz2'
  sha256 '4e278546171000c2db28ef1ec8bcb23db894a5709f8b0129e05874b4492a8842'
  homepage 'http://www.gtkmm.org/'

  depends_on 'glib'
  depends_on 'libsigc++'

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make install"
  end
end