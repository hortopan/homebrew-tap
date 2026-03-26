class Envz < Formula
  desc "Secure environment variable management with AES-256-GCM encryption and macOS Keychain"
  homepage "https://github.com/hortopan/envz"
  version "0.1.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/hortopan/envz/releases/download/v0.1.2/envz-aarch64-apple-darwin.tar.gz"
      sha256 "36ca25f04d2480968b4fc9e1830b90bcce1931334cf5c2d61bf9ac1b44a37180"
    else
      url "https://github.com/hortopan/envz/releases/download/v0.1.2/envz-x86_64-apple-darwin.tar.gz"
      sha256 "6f29e4ccb0f87c1d3ffd490129386ed073f4d26be495022e554d40d909c42ad7"
    end
  end

  def install
    bin.install "envz"
  end

  test do
    assert_match "envz", shell_output("#{bin}/envz --help")
  end
end
