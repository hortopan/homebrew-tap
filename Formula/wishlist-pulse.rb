class WishlistPulse < Formula
  desc "Steam Wishlist monitoring bot with web dashboard, Telegram and Discord notifications"
  homepage "https://github.com/hortopan/steam-wishlist-pulse"
  version "0.1.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hortopan/steam-wishlist-pulse/releases/download/v0.1.6/wishlist-pulse-aarch64-apple-darwin.tar.xz"
      sha256 "3e409cc493e0b88652a850aa671d84f60eec0c243acd985ba04d56097d6a8eb0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hortopan/steam-wishlist-pulse/releases/download/v0.1.6/wishlist-pulse-x86_64-apple-darwin.tar.xz"
      sha256 "8bce550b7fb489166a77d30809e6d59148e479a6ec69968947a60b73c4c11496"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hortopan/steam-wishlist-pulse/releases/download/v0.1.6/wishlist-pulse-aarch64-unknown-linux-musl.tar.xz"
      sha256 "c5caeefbf60840b6ef943ce1c07135ddf5fbb166d1394f46f6c8c223b3f2c8e6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hortopan/steam-wishlist-pulse/releases/download/v0.1.6/wishlist-pulse-x86_64-unknown-linux-musl.tar.xz"
      sha256 "821b89312432357d3f8054dc17a03235519b8611bda5fcc2782be216397a525a"
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
