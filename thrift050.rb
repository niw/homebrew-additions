require 'formula'

class Thrift050 < Formula
  homepage 'http://thrift.apache.org'
  url 'http://archive.apache.org/dist/incubator/thrift/0.5.0-incubating/thrift-0.5.0.tar.gz'
  sha1 'f6bef78306fd7b407646d3a03ce4cd3bd05424a0'

  head 'http://svn.apache.org/repos/asf/thrift/trunk'

  option "with-haskell", "Install Haskell binding"
  option "with-erlang", "Install Erlang binding"
  option "with-java", "Install Java binding"
  option "with-perl", "Install Perl binding"
  option "with-php", "Install Php binding"

  depends_on 'boost'
  depends_on :python => :optional

  keg_only <<-EOS
To avoid conflicts with the latest version of Thrift,
You'll need to add Cellar bin to your PATH variable.
EOS

  fails_with :clang

  def install
    system "./bootstrap.sh" if build.head?

    exclusions = ["--without-ruby"]

    exclusions << "--without-python" unless build.with? "python"
    exclusions << "--without-haskell" unless build.include? "with-haskell"
    exclusions << "--without-java" unless build.include? "with-java"
    exclusions << "--without-perl" unless build.include? "with-perl"
    exclusions << "--without-php" unless build.include? "with-php"
    exclusions << "--without-erlang" unless build.include? "with-erlang"

    ENV["PY_PREFIX"] = prefix  # So python bindins don't install to /usr!

    system "./configure", "--disable-debug",
                          "--prefix=#{prefix}",
                          "--libdir=#{lib}",
                          *exclusions
    ENV.j1
    system "make"
    system "make install"
  end

  def caveats
    s = <<-EOS.undent
    To install Ruby bindings:
      gem install thrift

    To install PHP bindings:
      export PHP_PREFIX=/path/to/homebrew/thrift/0.9.0/php
      export PHP_CONFIG_PREFIX=/path/to/homebrew/thrift/0.9.0/php_extensions
      brew install thrift --with-php

    EOS
    s += python.standard_caveats if python
  end
end
