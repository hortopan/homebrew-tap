class WishlistPulse < Formula
  desc "Steam Wishlist monitoring bot with web dashboard, Telegram and Discord notifications"
  homepage "https://github.com/hortopan/steam-wishlist-pulse"
  version "0.1.10"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hortopan/steam-wishlist-pulse/releases/download/v0.1.10/wishlist-pulse-aarch64-apple-darwin.tar.xz"
      sha256 "3bb0dba3136918ffd9a8e8285c737fe94b8271c89b93a3332a10203600a913ff"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hortopan/steam-wishlist-pulse/releases/download/v0.1.10/wishlist-pulse-x86_64-apple-darwin.tar.xz"
      sha256 "ed8dfe15e7eb461b577ac4d830223bbcce464e879767e9bdb9c2f833923f0490"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hortopan/steam-wishlist-pulse/releases/download/v0.1.10/wishlist-pulse-aarch64-unknown-linux-musl.tar.xz"
      sha256 "d348c22631ffc28bf14563b07a10bb04a3795855f31e573d8a9dbcfb968d544a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hortopan/steam-wishlist-pulse/releases/download/v0.1.10/wishlist-pulse-x86_64-unknown-linux-musl.tar.xz"
      sha256 "b478011a24bb3e752cdd128939bdaab0079b26e1928ad028c1c9bab78dd3c174"
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
