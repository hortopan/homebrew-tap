class Envz < Formula
  desc "Secure environment variable management with AES-256-GCM encryption and macOS Keychain"
  homepage "https://github.com/hortopan/envz"
  version "0.1.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/hortopan/envz/releases/download/v0.1.1/envz-aarch64-apple-darwin.tar.gz"
      sha256 "6f6ae532e22a6e926bb28f0f3ca5eb3bf72a4f668378d628276aa58e65e24a9f"
    else
      url "https://github.com/hortopan/envz/releases/download/v0.1.1/envz-x86_64-apple-darwin.tar.gz"
      sha256 "aa458aa6b301609d926b7a5db553520c01b9e24b27a36929b14cf65ee3927efd"
    end
  end

  def install
    bin.install "envz"
  end

  test do
    assert_match "envz", shell_output("#{bin}/envz --help")
  end
end
