class WishlistPulse < Formula
  desc "Steam Wishlist monitoring bot with web dashboard, Telegram and Discord notifications"
  homepage "https://github.com/hortopan/steam-wishlist-pulse"
  version "0.1.15"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hortopan/steam-wishlist-pulse/releases/download/v0.1.15/wishlist-pulse-aarch64-apple-darwin.tar.xz"
      sha256 "c4df9487ea62dcc1dec53d316dbf38185ba21b150e26ba3b6816dd717d4f4cb7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hortopan/steam-wishlist-pulse/releases/download/v0.1.15/wishlist-pulse-x86_64-apple-darwin.tar.xz"
      sha256 "511cfb956df4dc6db1d24d4114d79ac89ef2efc4f4c66ab7582ee63a49b509f4"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hortopan/steam-wishlist-pulse/releases/download/v0.1.15/wishlist-pulse-aarch64-unknown-linux-musl.tar.xz"
      sha256 "16e26e209c1e52766dafa22b6e30ab19e736905713b2dbfc9b6fd1d8923dc2cc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hortopan/steam-wishlist-pulse/releases/download/v0.1.15/wishlist-pulse-x86_64-unknown-linux-musl.tar.xz"
      sha256 "155bdd4ccb53ffe25f41f223261e1955f8a833f102418ca4e020393b6b8787a3"
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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "wishlist-pulse"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "wishlist-pulse"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "wishlist-pulse"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "wishlist-pulse"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
