require 'formula'

class Vfdecrypt < Formula
  homepage 'https://github.com/drakealleg/VFDecrypt'
  head 'https://github.com/drakealleg/VFDecrypt.git'

  def install
    system "make", "mac"
    bin.install "vfdecrypt"
  end
end
