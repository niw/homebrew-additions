require 'formula'

class Grep < Formula
  homepage 'http://www.gnu.org/software/grep/'
  url 'http://ftpmirror.gnu.org/grep/grep-2.13.tar.xz'
  mirror 'http://ftp.gnu.org/gnu/grep/grep-2.13.tar.xz'
  sha256 '461718cbd3f471cfd4c167aa7c31be72d9c18760b88186b5e0d1ab8345022dd0'

  depends_on 'xz' => :build
  depends_on 'pcre'

  def install
    # find the correct libpcre
    pcre = Formula.factory('pcre')
    ENV.append 'LDFLAGS', "-L#{pcre.lib} -lpcre -liconv"
    ENV.append 'CPPFLAGS', "-I#{pcre.include}"

    system "./configure", "--disable-dependency-tracking",
                          "--disable-nls",
                          "--prefix=#{prefix}",
                          "--infodir=#{info}",
                          "--mandir=#{man}"
    system "make"
    system "make install"
  end
end
