require 'formula'

class Readline5 < Formula
  homepage 'http://tiswww.case.edu/php/chet/readline/rltop.html'
  url 'ftp://ftp.gnu.org/pub/gnu/readline/readline-5.2.tar.gz'
  sha256 '12e88d96aee2cd1192500356f0535540db499282ca7f76339fb4228c31249f45'
  version '5.2.14'

  keg_only <<-EOS
OS X provides the BSD libedit library, which shadows libreadline.
In order to prevent conflicts when programs look for libreadline we are
defaulting this GNU Readline installation to keg-only.
EOS

  def patches
    {:p0 => (1..14).map{|patch|
        "http://ftp.gnu.org/pub/gnu/readline/readline-5.2-patches/readline52-#{sprintf('%03d', patch)}"
      }}
  end

  def install
    # Always build universal, per https://github.com/mxcl/homebrew/issues/issue/899
    ENV.universal_binary
    # Fix darwin detection for Lion, see https://github.com/mxcl/homebrew/issues/4782
    inreplace 'support/shobj-conf', 'darwin[89]*|darwin10*)', 'darwin[89]*|darwin1[01]*)'
    system "./configure", "--prefix=#{prefix}",
                          "--mandir=#{man}",
                          "--infodir=#{info}",
                          "--enable-multibyte"
    system "make install"
  end
end
