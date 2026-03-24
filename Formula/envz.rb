class Envz < Formula
  desc "Secure environment variable management with AES-256-GCM encryption and macOS Keychain"
  homepage "https://github.com/hortopan/envz"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/hortopan/envz/releases/download/v0.1.0/envz-aarch64-apple-darwin.tar.gz"
      sha256 "3a97e724dca1ff072867e371c4519f0baf1cef337cefc4623222809f591637eb"
    else
      url "https://github.com/hortopan/envz/releases/download/v0.1.0/envz-x86_64-apple-darwin.tar.gz"
      sha256 "9daa27bd400ea1df973374a48ac28b7fa41d197f6c07eeb4deb96e0e2a073589"
    end
  end

  def install
    bin.install "envz"
  end

  test do
    assert_match "envz", shell_output("#{bin}/envz --help")
  end
end
