class WishlistPulse < Formula
  desc "Steam Wishlist monitoring bot with web dashboard, Telegram and Discord notifications"
  homepage "https://github.com/hortopan/steam-wishlist-pulse"
  version "0.1.7"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hortopan/steam-wishlist-pulse/releases/download/v0.1.7/wishlist-pulse-aarch64-apple-darwin.tar.xz"
      sha256 "56a8b92e34952f6cb1ea79305e07ec81e5af79ff85b930ad40deabe5754e2bcf"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hortopan/steam-wishlist-pulse/releases/download/v0.1.7/wishlist-pulse-x86_64-apple-darwin.tar.xz"
      sha256 "be54725d1278ce2e6683590f861af1242d6d2d2229e916728df99fc869b2ff28"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hortopan/steam-wishlist-pulse/releases/download/v0.1.7/wishlist-pulse-aarch64-unknown-linux-musl.tar.xz"
      sha256 "f16f97c4ac2451f285022f5708d829cc907d4a552370c02b04259921d96b8341"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hortopan/steam-wishlist-pulse/releases/download/v0.1.7/wishlist-pulse-x86_64-unknown-linux-musl.tar.xz"
      sha256 "dc2e9e2925a33f430060ccff88e764c6f2281b45eafce86e8e0c730b7829088d"
    end
  end

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-pc-windows-gnu":              {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "wishlist-pulse" if OS.mac? && Hardware::CPU.arm?
    bin.install "wishlist-pulse" if OS.mac? && Hardware::CPU.intel?
    bin.install "wishlist-pulse" if OS.linux? && Hardware::CPU.arm?
    bin.install "wishlist-pulse" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
