class WishlistPulse < Formula
  desc "Steam Wishlist monitoring bot with web dashboard, Telegram and Discord notifications"
  homepage "https://github.com/hortopan/steam-wishlist-pulse"
  version "0.1.8"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hortopan/steam-wishlist-pulse/releases/download/v0.1.8/wishlist-pulse-aarch64-apple-darwin.tar.xz"
      sha256 "05f8edef3126e4d6ef4b350f8a2bee8e8607c74423c6563a00f1a183812c7b1d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hortopan/steam-wishlist-pulse/releases/download/v0.1.8/wishlist-pulse-x86_64-apple-darwin.tar.xz"
      sha256 "dfb942c3ba89e4776e896d109ca43cd78ea00b838297b5cef812e9442e6fb948"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hortopan/steam-wishlist-pulse/releases/download/v0.1.8/wishlist-pulse-aarch64-unknown-linux-musl.tar.xz"
      sha256 "6a817cf295559244b7db8f04c87768139257c7b206ead2b2c2531a3343baabd7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hortopan/steam-wishlist-pulse/releases/download/v0.1.8/wishlist-pulse-x86_64-unknown-linux-musl.tar.xz"
      sha256 "1ea006799867195a52a9a38054ec8f1dfa342f184c58599b2069432340aca28a"
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
