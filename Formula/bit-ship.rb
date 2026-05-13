class BitShip < Formula
  desc "Bit-Ship CLI is tool that analyses your code and generates a custom environment for your needs\nYou can use if to local development, CI/CD or even production."
  homepage "https://www.bit-ship.dev"

  url "https://registry.npmjs.org/bit-ship/-/bit-ship-1.0.0.tgz"
  sha256 "60c61e21477c3af177a7ece57a4afeec3f56858f5b8fe185d7502ee5dc49ca88"

  version "1.0.0"
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
