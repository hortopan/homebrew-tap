class WishlistPulse < Formula
  desc "Steam Wishlist monitoring bot with web dashboard, Telegram and Discord notifications"
  homepage "https://github.com/hortopan/steam-wishlist-pulse"
  version "0.1.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hortopan/steam-wishlist-pulse/releases/download/v0.1.3/wishlist-pulse-aarch64-apple-darwin.tar.xz"
      sha256 "9a19c5a12c87a7945c0c91af09bd6a4d3075aad787a24e6867c8dcc7b05bd757"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hortopan/steam-wishlist-pulse/releases/download/v0.1.3/wishlist-pulse-x86_64-apple-darwin.tar.xz"
      sha256 "1541deb956333d4f25463044113192a0e36cd41526e9e6406d39f5d0d9647063"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hortopan/steam-wishlist-pulse/releases/download/v0.1.3/wishlist-pulse-aarch64-unknown-linux-musl.tar.xz"
      sha256 "833bc7527ba801f5e9d0085c667993e41dcc17c2520c7ff48b3c1903dc5fe37a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hortopan/steam-wishlist-pulse/releases/download/v0.1.3/wishlist-pulse-x86_64-unknown-linux-musl.tar.xz"
      sha256 "856ded3bd8afc9669d015f58c3f7890c75922bc541fcf2c44e6430e29a36ee46"
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
