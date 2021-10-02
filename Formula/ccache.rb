class Ccache < Formula
  desc "Object-file caching compiler wrapper"
  homepage "https://ccache.dev/"
  license "GPL-3.0-or-later"
  head "https://github.com/niw/ccache.git", :branch => "wip"

  depends_on "cmake" => :build
  depends_on "zstd"

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

  test do
    system "#{bin}/ccache", "-s"
  end
end
