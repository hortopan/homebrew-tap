class WishlistPulse < Formula
  desc "Steam Wishlist monitoring bot with web dashboard, Telegram and Discord notifications"
  homepage "https://github.com/hortopan/steam-wishlist-pulse"
  version "0.1.16"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hortopan/steam-wishlist-pulse/releases/download/v0.1.16/wishlist-pulse-aarch64-apple-darwin.tar.xz"
      sha256 "53580e9631b632304747916ad2e9cc40dad69cb3dbbfdf586143b81242b0c095"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hortopan/steam-wishlist-pulse/releases/download/v0.1.16/wishlist-pulse-x86_64-apple-darwin.tar.xz"
      sha256 "ecf6642cf5cb3627d59dd6dd75824ffb5c1e87556969116aab82f6802f60ce5f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hortopan/steam-wishlist-pulse/releases/download/v0.1.16/wishlist-pulse-aarch64-unknown-linux-musl.tar.xz"
      sha256 "5433558e0f98db1dddca31a76339d8f0ecf5ee58730684c5a017f4be373fff6a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hortopan/steam-wishlist-pulse/releases/download/v0.1.16/wishlist-pulse-x86_64-unknown-linux-musl.tar.xz"
      sha256 "597d119609da28680cf4ae5244124c30ead84233d836520337e9dea461bf280d"
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
