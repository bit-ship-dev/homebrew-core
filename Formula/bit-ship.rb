class BitShip < Formula
  desc "Bit-Ship CLI is tool that analyses your code and generates a custom environment for your needs\nYou can use if to local development, CI/CD or even production."
  homepage "https://www.bit-ship.dev"

  url "https://registry.npmjs.org/bit-ship/-/bit-ship-0.5.0-0ed3303.tgz"
  sha256 "c454cede824d293c5014bc1314e9ead25f4a75751901463ab6731ceec4b130d9"

  version "0.5.0-0ed3303"
  license "MIT"

  depends_on "node@24"
  depends_on "podman"

  def install
    libexec.install Dir["*"]
    node = Formula["node@24"].opt_bin/"node"

    %w[bit-ship bitship].each do |cmd|
      (bin/cmd).write <<~EOS
        #!/bin/bash
        exec "#{node}" "#{libexec}/bin/bin.js" "$@"
      EOS
    end

    %w[bit-pod bitpod].each do |cmd|
      (bin/cmd).write <<~EOS
        #!/bin/bash
        exec "#{node}" "#{libexec}/bin/pod.js" "$@"
      EOS
    end
  end

  test do
    system "#{bin}/bit-ship", "--version"
    system "#{bin}/bit-pod", "--version"
  end
end
