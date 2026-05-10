class BitShip < Formula
  desc "Container tool"
  homepage "https://www.bit-ship.dev"

  url "https://registry.npmjs.org/bit-ship/-/bit-ship-0.5.0-1eb2838.tgz"
  sha256 "0bac06268ad8b1be3de6bfc10db65ea798e3e4e761fcce5525e69b867f5ae701"

  version "0.5.0-27c4463"
  license "MIT"

  depends_on "node"
  depends_on "podman"

  def install
    system "#{Formula["node"].opt_bin}/npm", "install", "-g", "--prefix", prefix, "bit-ship"
    bin.install_symlink "bit-ship" => "bit-pod"
    bin.install_symlink "bit-ship" => "bitship"
    bin.install_symlink "bit-ship" => "bitpod"
  end

  test do
    system "#{bin}/bit-ship", "--version"
  end
end
