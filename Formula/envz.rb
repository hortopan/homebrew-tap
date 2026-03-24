class Envz < Formula
  desc "Secure environment variable management with AES-256-GCM encryption and macOS Keychain"
  homepage "https://github.com/hortopan/envz"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/hortopan/envz/releases/download/v0.1.0/envz-aarch64-apple-darwin.tar.gz"
      sha256 "b5dbf206953f211b9bcf3d11d42c21eb56392f02c6f10402827e61cc0512b39f"
    else
      url "https://github.com/hortopan/envz/releases/download/v0.1.0/envz-x86_64-apple-darwin.tar.gz"
      sha256 "fd93ab8ab39f9e8758033276223d3e043b269442556f16e03c7b379977ca78c8"
    end
  end

  def install
    bin.install "envz"
  end

  test do
    assert_match "envz", shell_output("#{bin}/envz --help")
  end
end
